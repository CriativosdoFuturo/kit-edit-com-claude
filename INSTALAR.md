# Instalar o kit do curso Edit com Claude Code

**Trombino / Criativos do Futuro**

Leitura direta, sem a interface do GitHub:
https://raw.githubusercontent.com/CriativosdoFuturo/kit-edit-com-claude/main/INSTALAR.md

## Para o aluno

Mande o link desta página para o Claude, na aba **Code**, junto com o prompt da aula. O Claude
cria a pasta do curso, baixa o kit com as skills e prepara tudo. Você só aprova as permissões que
aparecerem.

| Parte | Aula | O que instala |
|---|---|---|
| **1. Kit e skills** | 03 | pasta do curso, as 16 skills (valendo em qualquer conversa) e a decupagem (Python, FFmpeg) |
| **2. HyperFrames** | 06 | o motor de animação (Node) e o teste de 8 segundos |
| **Atualizar** | quando avisarmos | a versão nova do kit, sem perder seus projetos |

A conexão com o editor (MCP) tem um link próprio em cada editor. O do Premiere é
[INSTALAR-PREMIERE.md](https://github.com/CriativosdoFuturo/kit-edit-com-claude/blob/main/INSTALAR-PREMIERE.md).

---

## Instruções para o Claude

**Regras que valem em todas as partes:**

- Explique cada etapa ao aluno em uma frase, em português simples. Ele pode nunca ter usado um
  terminal.
- Use o terminal para fazer o trabalho. Não entregue uma lista de comandos para o aluno rodar
  quando você mesmo puder rodar.
- Se precisar de uma ação dele (aprovar uma permissão, fechar um programa), peça uma ação por vez
  e espere a confirmação.
- Não use APIs pagas. Não mexa em projetos, mídias ou configurações do aluno fora da pasta do
  curso. A única exceção é o passo "Skills no Claude todo", feito pelo script do kit, que faz
  backup antes.
- Não desative antivírus, não crie exclusões, não remova alertas, não desligue a validação de
  certificados e não mude políticas do sistema. Se algo for bloqueado, explique o bloqueio e
  oriente o aluno a falar com o suporte.
- Downloads demorados (modelos, dependências) vão para segundo plano. Avise o aluno quanto tempo
  costuma levar.
- Se a correção de um erro precisar de uma nova autorização do aluno, explique o que propõe e
  termine com:

  **Quer que eu resolva isso pra você?**
  Responda "Sim, pode resolver" para eu continuar.

**Endereços:**

- Kit (zip): `https://raw.githubusercontent.com/CriativosdoFuturo/kit-edit-com-claude/main/kit-edit-com-claude.zip`
- SHA-256 do kit: `https://raw.githubusercontent.com/CriativosdoFuturo/kit-edit-com-claude/main/kit-edit-com-claude.sha256`

**Pasta do curso** (chamada aqui de `PASTA`):

- Windows: a pasta Documentos do usuário + `\Edit com Claude`. Descubra a pasta Documentos com
  `[Environment]::GetFolderPath('MyDocuments')`, porque ela pode estar no OneDrive.
- Mac: `~/Documents/Edit com Claude`

---

### Parte 1 · Kit e skills (aula 03)

1. **Identifique** o sistema (Windows ou Mac), a arquitetura e o espaço livre. A Parte 1 precisa
   de uns 6 GB livres no disco da pasta Documentos. Se faltar espaço, avise o aluno; não apague
   nada.

2. **Escolha a pasta:**
   - `PASTA` não existe: crie.
   - `PASTA` existe e tem `CLAUDE.md` e `edition.json`: o kit já está instalado. Siga para
     **Atualizar o kit**.
   - `PASTA` existe com outros arquivos: não misture. Pergunte ao aluno se pode usar
     `Edit com Claude 2`.

3. **Baixe o kit:**
   - baixe o zip e o `.sha256` numa pasta temporária nova;
   - confira o SHA-256 (Windows: `Get-FileHash`; Mac: `shasum -a 256`). Se não bater, pare e avise
     o aluno; não use o arquivo;
   - extraia na pasta temporária. O zip traz uma pasta `kit-edit-com-claude/`; copie o conteúdo
     dela para `PASTA`;
   - leia `README.md` e `CLAUDE.md` da `PASTA`.

4. **Instale o que a decupagem precisa**, se faltar:
   - Python 3.10 ou superior. Windows: `winget install --id Python.Python.3.13 -e`. Mac:
     `brew install python`.
   - FFmpeg. Windows: `winget install --id Gyan.FFmpeg -e`. Mac: `brew install ffmpeg`.
   - No Mac, se o Homebrew não existir, instale pela documentação oficial
     (https://docs.brew.sh/Installation), com as confirmações que ela pede.
   - Depois de um `winget install`, o terminal atual pode não enxergar o programa novo. Procure o
     caminho completo do executável em vez de pedir para o aluno reiniciar.

5. **Crie o ambiente da decupagem** na `PASTA`, seguindo
   `.claude/skills/decupagem-pt/SKILL.md` (seção "Preparação"):
   - `python -m venv .venv`;
   - instale o torch e o `requirements.txt` da skill.

   Leva de 5 a 20 minutos, conforme a internet. Rode em segundo plano. Os modelos de transcrição
   (cerca de 3 GB) só são baixados na primeira decupagem, não agora.

6. **Skills no Claude todo.** Rode, com o Python da `.venv`:
   - Windows: `& "PASTA\.venv\Scripts\python.exe" -I "PASTA\scripts\instalar_skills_globais.py"`
   - Mac: `"PASTA/.venv/bin/python" -I "PASTA/scripts/instalar_skills_globais.py"`

   O script copia as 16 skills para as skills pessoais do Claude (`~/.claude/skills/`), para elas
   aparecerem em **qualquer** conversa. Cada cópia sabe onde está a `PASTA`, e é lá que ficam os
   programas, as regras do curso e os projetos. O script também libera o acesso fixo do Claude à
   `PASTA` (em `~/.claude/settings.json`, com backup em `PASTA/backups/`), para o aluno não ter
   que aprovar acesso a cada pedido. Rodar de novo só atualiza.
   - Se ele disser que **não mexeu** numa skill porque já existia outra com o mesmo nome, não
     apague a do aluno. Conte para ele qual foi e siga.
   - Se ele disser que **não mexeu** no acesso fixo, explique o motivo que ele mostrou. As skills
     funcionam mesmo assim; o Claude só vai pedir permissão para usar a pasta do curso.

7. **Confira:**
   - `.claude/skills/` da `PASTA` tem 16 pastas, cada uma com `SKILL.md`;
   - `~/.claude/skills/` tem as 16 pastas do kit (cada uma com `.kit-edit-com-claude.json`);
   - `.venv` importa `faster_whisper`, `transformers` e `torch` sem erro;
   - `ffmpeg -version` responde.

8. **Termine com um resumo curto para o aluno**, sem termos técnicos:
   - o que foi instalado e o que ficou pendente;
   - o caminho da `PASTA` (é onde ficam os projetos dele);
   - **o próximo passo:** abrir uma **conversa nova** no Claude, na aba Code. As skills do curso
     aparecem em qualquer conversa;
   - **como conferir:** nessa conversa nova, digitar **/trombino**. Aparecem todas as skills do
     curso juntas, como **/trombino-decupagem-pt**, **/trombino-edit-video** e **/trombino-hyperframes**. Se não aparecerem, digitar
     **/reload-skills** ou abrir outra conversa nova;
   - que a conexão com o editor (MCP) é o próximo passo da aula.

---

### Parte 2 · HyperFrames (aula 06)

Trabalhe na `PASTA`. Se ela não tiver o kit, faça a Parte 1 antes.

1. **Node 22 ou superior.** Se faltar: Windows `winget install --id OpenJS.NodeJS.LTS -e`; Mac
   `brew install node`.
2. **Prepare o kit**, nesta ordem: `npm ci`, `npm run setup`, `npx hyperframes browser ensure`
   (baixa o navegador do render) e `npm run check`.
   - Avisos do npm sobre scripts de instalação bloqueados não impedem o render. Siga em frente e
     confira pelo teste.
3. **Teste de 8 segundos:**
   - `npm run new-video -- primeiro-teste`. Se a pasta já existir, use outro nome, como
     `primeiro-teste-2`;
   - `npx hyperframes render video-projects/primeiro-teste --output renders/primeiro-teste.mp4 --quality draft --workers 1`;
   - confira o arquivo com `ffprobe`: duração de uns 8 segundos e vídeo presente.
4. **Mostre o resultado ao aluno:** onde está o vídeo, o que funcionou e o que ficou pendente.

---

### Atualizar o kit

Use quando o aluno pedir para atualizar, ou quando a Parte 1 encontrar o kit já instalado.

1. Leia a versão instalada em `PASTA/edition.json`.
2. Baixe o zip novo e o `.sha256` numa pasta temporária nova. Confira o SHA-256 e extraia.
3. Compare as versões. Se forem iguais, diga ao aluno que ele já está na versão mais nova e pare.
4. **Faça backup** antes de trocar: copie `CLAUDE.md`, `README.md`, `edition.json`, `.claude/`,
   `docs/` e `scripts/` da `PASTA` para `PASTA/backups/kit-<versão antiga>-<data>/`.
5. Copie os arquivos novos por cima. **Nunca apague nem substitua:**
   - `video-projects/`, `renders/` e `backups/`;
   - `.venv/` e `node_modules/`;
   - `.env` e `PERFIL-DE-EDICAO.md`;
   - skills que o aluno criou (pastas em `.claude/skills/` que não vêm no kit novo).
6. Se o `package-lock.json` mudou, rode `npm ci`. Se o `requirements.txt` da decupagem mudou,
   reinstale-o na `.venv`.
7. Rode de novo o script do passo 6 da Parte 1 (**Skills no Claude todo**), para as cópias
   pessoais das skills ficarem iguais às novas.
8. Diga ao aluno o que mudou (veja `VALIDACAO.md` e `edition.json`) e peça para ele abrir uma
   **conversa nova**, para as skills novas aparecerem.
