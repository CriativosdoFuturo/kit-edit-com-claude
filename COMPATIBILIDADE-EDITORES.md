# Conectar cada editor ao Claude — orientações do curso

**Curso Edit com Claude Code · revisão de 04/11/2026**

O caminho é sempre o mesmo: o aluno manda o link do editor e o prompt da aula para o Claude, no
computador onde edita. Antes de instalar, confira:

- o editor, a edição (gratuita ou paga) e a versão;
- o sistema;
- as integrações que já existem.

Preserve o que já funciona. Não prometa que todos os editores fazem as mesmas coisas.

Estas orientações complementam a documentação dos autores e não alteram os projetos de terceiros.

## Premiere

Use [INSTALAR-PREMIERE.md](./INSTALAR-PREMIERE.md). Quem já está conectado não precisa reinstalar.

Quem tem a instalação do curso anterior não precisa baixar nada de novo: o instalador só liga essa
instalação ao Claude.

A checagem confere dependências, conexão e leitura, sem edição de teste. No Mac, a instalação
precisa ser confirmada na própria máquina.

## DaVinci Resolve

Projeto: https://github.com/samuelgursky/davinci-resolve-mcp

Identifique se é o **Studio** ou o **gratuito**, e a versão.

- **Studio:** é o caminho principal da integração, que usa a API de scripting, segundo o README do
  autor. Siga os requisitos e o procedimento atual do autor e confirme a conexão local.
- **Gratuito:** a documentação descreve uma ponte interna até a versão 21.0.x. Na 21.1, o caminho
  dos scripts Python deixou de funcionar. Então não ofereça essa ponte como solução comprovada na
  21.1. Explique a limitação e só ofereça uma alternativa com suporte documentado para a versão
  encontrada.

Não recomende voltar de versão nem comprar o Studio por conta própria.

O pacote npm 4.18.5 não traz o `requirements.txt`. Se a prévia AAF falhar, confira o `pyaaf2` no
Python usado pelo servidor.

## CapCut Windows

Projeto: https://github.com/yabdulaziz2009-dev/capcut-mcp

É uma integração comunitária, não oficial. Ela lê e altera rascunhos, legendas e overlays, mas não
faz cortes na timeline.

- Instale a partir do código, seguindo os requisitos do autor. Não invente um ZIP de release.
- O autor testou no CapCut 9.1.0 e exige o CapCut fechado para gravar no rascunho.
- A preparação não deve alterar projetos.

## CapCut Mac

Projeto: https://github.com/drhema/mcp-cut

O README do autor usa um marcador no lugar do endereço. O comando completo é:

```sh
git clone https://github.com/drhema/mcp-cut.git
cd mcp-cut
uv sync
```

Antes de rodar:

- leia os fontes e os requisitos;
- não clone por cima de uma pasta que já existe.

O autor relata testes no CapCut 8.5 para macOS. Confira a pasta de rascunhos e a compatibilidade
sem editar material do aluno.

## Final Cut Pro (Mac)

Projeto: https://github.com/DareDev256/fcp-mcp-server

O fluxo usa **FCPXML**. Para trabalhar numa timeline existente, o aluno exporta o XML no Final Cut
(**Arquivo > Exportar XML**). Essa exportação é a forma de acesso ao projeto, não um erro.

Preserve o XML original e trabalhe numa cópia.

## Condução

- Confira a instalação e a conexão sem exigir edição de teste.
- Quando faltar uma ação do aluno, peça uma por vez.
- Quando uma correção precisar de nova autorização, explique a causa e a mudança e termine com
  **"Quer que eu resolva isso pra você?"**.
- Quando estiver funcionando, confirme o resultado sem oferecer correção desnecessária.

Os MCPs de DaVinci, CapCut e Final Cut não foram testados com o Claude neste curso.
