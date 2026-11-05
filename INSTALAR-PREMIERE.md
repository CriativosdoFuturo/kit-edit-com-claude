# Conectar o Adobe Premiere ao Claude Code

**Curso Edit com Claude Code · Trombino / Criativos do Futuro · pacote `claude-1.0.1`**

Leitura direta, sem a interface do GitHub:
https://raw.githubusercontent.com/CriativosdoFuturo/kit-edit-com-claude/main/INSTALAR-PREMIERE.md

## Para o aluno

Copie o link desta página e mande para o Claude, na aba **Code**, junto com o prompt da aula. O
Claude faz a instalação e confere a conexão. Você só precisa:

- ter o Premiere instalado e licenciado neste computador;
- abrir um projeto seu quando ele pedir;
- abrir o painel **Janela > Extensões > MCP Bridge** quando ele pedir;
- aprovar as permissões que aparecerem.

A primeira instalação baixa uns 550 MB (FFmpeg, Whisper e o modelo de voz). Nenhuma edição de
teste é feita no seu projeto.

---

## Instruções para o Claude

**Objetivo:** instalar a conexão do Premiere com o Claude Code e a transcrição local, conferir só
a instalação e a conexão, sem editar nada, e dizer ao aluno, em português simples, o próximo passo.

Use os scripts do pacote no terminal, para economizar uso. Explique cada etapa ao aluno em uma
frase. Se precisar de uma ação dele, peça uma ação por vez e espere a confirmação.

### 1. Antes de instalar

1. Confirme que está no Windows ou no Mac do aluno, onde o Premiere está instalado. Anote o sistema,
   a arquitetura e a versão do Premiere. Não instale nem atualize o Premiere.
2. Veja se o Claude já tem um MCP chamado `trombs-premiere` (arquivo `~/.claude.json`, chave
   `mcpServers`). Se tiver, teste se ele funciona antes de qualquer coisa. Se funcionar, use esse e
   pare aqui: não reinstale nem substitua.
   - Se houver um MCP com o nome antigo, `premiere_pro_trombino`, que aponta para a pasta da
     instalação do curso (passo 3), o instalador só troca o nome dele para `trombs-premiere`, com
     backup. Rode o instalador normalmente.
   - Se o `premiere_pro_trombino` apontar para outro lugar, é um MCP de outra origem: não mexa nele.
     Pergunte ao aluno se quer manter os dois antes de instalar.
3. Veja se já existe a pasta da instalação do curso anterior:
   - Windows: `%LOCALAPPDATA%\CriativosdoFuturo\PremiereMCP\installation.json`
   - Mac: `~/Library/Application Support/CriativosdoFuturo/PremiereMCP/installation.json`

   Se existir, o instalador só liga essa instalação ao Claude (`--register-existing`), sem baixar
   nada de novo.
4. Confira se há pelo menos 3 GB livres. Se faltar espaço, mostre os discos ao aluno e deixe ele
   escolher outra pasta (`--root`). Não apague arquivos.

### 2. Instalar

O pacote fica neste repositório:

- [premiere-setup-claude-1.0.1.zip](./premiere-setup-claude-1.0.1.zip)
- SHA-256: `6d552d0ca052170c125c59cfc88fc776529ab7c159936ee7984449ec2035c07b` (também em [premiere-setup-claude-1.0.1.sha256](./premiere-setup-claude-1.0.1.sha256))

Download direto:
`https://raw.githubusercontent.com/CriativosdoFuturo/kit-edit-com-claude/main/premiere-setup-claude-1.0.1.zip`

**Caminho principal, com Node 22.19+ ou 24.5+ já instalado:**

1. Baixe o zip numa pasta temporária nova e confira o SHA-256. Se não bater, pare e avise o aluno.
2. Extraia numa pasta nova. Leia `LEIA-PRIMEIRO.txt`, `COMO-CONDUZIR.txt` e `install.mjs` antes de
   executar.
3. Na pasta extraída, rode `node install.mjs --preflight`. Ele só confere; não altera nada.
4. Se aprovar, rode `node install.mjs`.
   - Se terminar com código 3 (`EXISTING_INSTALLATION_NOT_IN_CLAUDE`), rode
     `node install.mjs --register-existing`.

**Sem Node compatível:**

- Windows: instale o Node LTS oficial (`winget install --id OpenJS.NodeJS.LTS -e`) ou use o script
  opcional [instalar-premiere.ps1](./instalar-premiere.ps1), se a política do PowerShell permitir.
  Não use `-ExecutionPolicy Bypass`.
- Mac: rode [instalar-premiere-mac.sh](./instalar-premiere-mac.sh) com `bash`. FFmpeg e Whisper
  vêm pelo Homebrew. Se o Homebrew não existir, instale pela documentação oficial
  (https://docs.brew.sh/Installation), com as confirmações que ela pede.

**O que o instalador faz:**

- cria a pasta da instalação (Windows: `%LOCALAPPDATA%\CriativosdoFuturo\PremiereMCP`; Mac:
  `~/Library/Application Support/CriativosdoFuturo/PremiereMCP`);
- baixa FFmpeg, Whisper e o modelo de voz, conferindo o hash de cada um;
- copia o painel MCP Bridge (CEP, assinado) para as extensões da Adobe do usuário;
- liga a opção `PlayerDebugMode` da Adobe, guardando os valores anteriores;
- faz backup do `~/.claude.json` e acrescenta só a entrada `trombs-premiere`.

Ele não mexe em outros MCPs, nem no Codex, nem nas proteções do sistema.

### 3. Conferir, sem editar

Na pasta instalada, com o Node dela (`runtime/node.exe` no Windows, `runtime/node` no Mac):

1. `doctor.mjs`: confere arquivos, FFmpeg, Whisper e o modelo.
2. Antes do painel, confira se há um projeto aberto no Premiere. Se o Premiere estiver na tela
   inicial, peça ao aluno para abrir o projeto dele. Se ele não tiver um, explique como criar um
   projeto vazio, se ele quiser. Só depois peça: **Janela > Extensões > MCP Bridge**, deixando o
   painel aberto.
3. `connection.mjs --connect`: confere a resposta real do Premiere e lê a lista de sequências. Não
   corta, não importa, não renderiza e não salva nada.
4. Antes de reiniciar o Premiere, peça ao aluno para salvar o trabalho e espere a confirmação.

**Pronto** quer dizer: dependências respondendo **e** resposta real do Premiere (`ready: true`).
Não diga que todas as funções de edição foram testadas.

O MCP novo aparece nas **conversas novas** do Claude. No fim, peça ao aluno para abrir uma conversa
nova e escrever: **/trombs-premiere confere se o Premiere está conectado**.

### 4. Se der erro

- Explique ao aluno em uma frase o que aconteceu e o que você propõe.
- Não desative antivírus, não crie exclusões, não remova alertas, não desligue a validação de
  certificados e não mude políticas do sistema. Se houver bloqueio de segurança, anote o nome da
  detecção, o caminho e o hash, sem executar o arquivo bloqueado, e oriente o aluno a falar com o
  suporte.
- Não apague pastas para passar das proteções do instalador (`EXISTING_INSTALLATION`). Leia
  `COMO-CONDUZIR.txt`, que explica cada mensagem.
- Se a correção precisar de uma nova autorização do aluno, termine com:

  **Quer que eu resolva isso pra você?**
  Responda "Sim, pode resolver" para eu continuar.

## Versão

`claude-1.0.1` (05/11/2026): o MCP passou a se chamar `trombs-premiere`, para ficar junto das
skills do curso (`/trombs...`). Instalações da `claude-1.0.0` têm o nome trocado sem reinstalar.

`claude-1.0.0` (04/11/2026), adaptado do pacote 1.3.5 do curso anterior. É o mesmo servidor
(`adobe-premiere-pro-mcp` 1.2.8, CEP), o mesmo painel assinado e a mesma transcrição local. O que
mudou: o registro é feito no Claude Code, e uma instalação existente é reaproveitada sem baixar nada.

**Testado nesta versão:**

- conferência e registro numa configuração de teste;
- recusa em sobrescrever um MCP já existente;
- troca do nome antigo para `trombs-premiere` só quando a entrada é da instalação do curso
  (preservando o resto da configuração), e nenhuma mudança num MCP de outra origem;
- servidor iniciando e mostrando o catálogo de ferramentas.

**Ainda não testado:** instalação completa num computador limpo e conexão com o Premiere por este
pacote. Também não houve teste nativo no Mac.

Base: [MCP original](https://github.com/hetpatel-11/Adobe_Premiere_Pro_MCP). Licenças em
`THIRD_PARTY_NOTICES.md`, dentro do pacote.
