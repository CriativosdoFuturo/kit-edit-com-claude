#!/usr/bin/env bash
# Premiere MCP para o Claude Code (claude-1.0.0) - preparacao no Mac. Nao usa Codex.
set -euo pipefail
[[ "$(uname -s)" == Darwin ]] || { echo 'Use o Mac onde o Premiere esta instalado.'; exit 1; }
STAGE="$(mktemp -d)"
NODE_BIN="$(command -v node || true)"
if [[ -n "$NODE_BIN" ]] && ! "$NODE_BIN" --input-type=module -e "import tls from 'node:tls'; process.exit(typeof tls.getCACertificates==='function' && typeof tls.setDefaultCACertificates==='function' ? 0 : 1)"; then NODE_BIN=""; fi
if [[ -z "$NODE_BIN" ]]; then
 if [[ "$(uname -m)" == arm64 ]]; then ARCH=arm64; HASH=bed7eea5325e1108f32ce5228ddd6a5f0f08a499ee42aa7442aea583702f6057; else ARCH=x64; HASH=1462cb3b3046b815cf8ea436d3da450ec1a9f11dac7e5a46b0ada5305d7e8097; fi
 curl --fail --location --retry 3 "https://nodejs.org/dist/v24.21.0/node-v24.21.0-darwin-$ARCH.tar.gz" -o "$STAGE/node.tar.gz"
 [[ "$(shasum -a 256 "$STAGE/node.tar.gz" | awk '{print $1}')" == "$HASH" ]] || exit 1
 tar -xzf "$STAGE/node.tar.gz" -C "$STAGE"
 NODE_BIN="$STAGE/node-v24.21.0-darwin-$ARCH/bin/node"
fi
curl --fail --location --retry 3 'https://raw.githubusercontent.com/CriativosdoFuturo/kit-edit-com-claude/main/premiere-setup-claude-1.0.0.zip' -o "$STAGE/setup.zip"
[[ "$(shasum -a 256 "$STAGE/setup.zip" | awk '{print $1}')" == "a7b9048b07de705bb0f3fe81888af04e8a97f3e18f2a4b21ef70c49c65049ca5" ]] || { echo 'SHA256 divergente; nao executar.'; exit 1; }
mkdir "$STAGE/setup"; unzip -q "$STAGE/setup.zip" -d "$STAGE/setup"
set +e
"$NODE_BIN" "$STAGE/setup/install.mjs"; CODE=$?
# 3 = ja existe instalacao do curso anterior: so liga ao Claude, sem baixar nada.
if [[ $CODE -eq 3 ]]; then "$NODE_BIN" "$STAGE/setup/install.mjs" --register-existing; CODE=$?; fi
set -e
[[ $CODE -eq 0 ]] || { echo 'A instalacao informou uma pendencia. Preserve a mensagem e diagnostique; nao repita em loop.'; exit 1; }
ROOT="$HOME/Library/Application Support/CriativosdoFuturo/PremiereMCP"
"$ROOT/runtime/node" "$ROOT/doctor.mjs"
"$ROOT/runtime/node" "$ROOT/connection.mjs" --connect
