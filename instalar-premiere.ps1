[CmdletBinding()]
param([string]$NodePath,[string]$Root,[string]$StageRoot)
# Premiere MCP para o Claude Code (claude-1.0.0) - preparacao opcional no Windows.
# Baixa o pacote do curso, confere o SHA-256, instala e registra no Claude. Nao usa Codex.
$ErrorActionPreference='Stop'
$TaskIdentity=[Security.Principal.WindowsIdentity]::GetCurrent().Name
if(($TaskIdentity.Split('\')[-1]) -match '(?i)^codexsandbox'){throw 'RESTRICTED_EXECUTION: execute na conta do usuario do Premiere. Nenhum download ou instalacao iniciado.'}

if(-not $Root){$Root=Join-Path $env:LOCALAPPDATA 'CriativosdoFuturo/PremiereMCP'}
if(-not $StageRoot){$StageRoot=$env:TEMP}
$TaskStageDrive=Get-PSDrive -Name ([IO.Path]::GetPathRoot($StageRoot).TrimEnd('\').TrimEnd(':'))
if($null -eq $TaskStageDrive.Free -or $TaskStageDrive.Free -lt 512MB){throw 'INSUFFICIENT_STAGE_SPACE: selecione -StageRoot em um disco com pelo menos 512 MB livres. Nao apague arquivos automaticamente.'}
$TaskStage=Join-Path $StageRoot ('trombino-premiere-claude-'+[guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $TaskStage | Out-Null
function DownloadVerified([string]$Url,[string]$File,[string]$Hash){
 Invoke-WebRequest -Uri $Url -OutFile $File -UseBasicParsing
 if((Get-FileHash -LiteralPath $File -Algorithm SHA256).Hash.ToLowerInvariant() -ne $Hash){throw "SHA256 divergente: $File. Nao executar."}
}
if(-not $NodePath){$cmd=Get-Command node -ErrorAction SilentlyContinue;if($cmd){$NodePath=$cmd.Source}}
if($NodePath){
 & $NodePath --input-type=module -e "import tls from 'node:tls'; process.exit(typeof tls.getCACertificates==='function' && typeof tls.setDefaultCACertificates==='function' ? 0 : 1)"
 if($LASTEXITCODE -ne 0){$NodePath=$null}
}
if(-not $NodePath){
 $Arch=if([Runtime.InteropServices.RuntimeInformation]::OSArchitecture -eq 'Arm64'){'arm64'}else{'x64'}
 $Hashes=@{x64='158f7685b44de51f6c0df1d153526cbcd3e1bc739a8dfc607721cef75de9e541';arm64='8779b1bde1d39f8d420e3b57aa657b39891af434d3de44a919044cec06785921'}
 $Name="node-v24.21.0-win-$Arch";$Zip=Join-Path $TaskStage 'node.zip'
 DownloadVerified "https://nodejs.org/dist/v24.21.0/$Name.zip" $Zip $Hashes[$Arch]
 Expand-Archive -LiteralPath $Zip -DestinationPath $TaskStage
 $NodePath=Join-Path $TaskStage "$Name/node.exe"
}
$Bundle=Join-Path $TaskStage 'setup.zip'
DownloadVerified 'https://raw.githubusercontent.com/CriativosdoFuturo/kit-edit-com-claude/main/premiere-setup-claude-1.0.0.zip' $Bundle 'a7b9048b07de705bb0f3fe81888af04e8a97f3e18f2a4b21ef70c49c65049ca5'
$Extract=Join-Path $TaskStage 'setup';Expand-Archive -LiteralPath $Bundle -DestinationPath $Extract
& $NodePath (Join-Path $Extract 'install.mjs') --root $Root
# 3 = ja existe instalacao do curso anterior: so liga ao Claude, sem baixar nada.
if($LASTEXITCODE -eq 3){& $NodePath (Join-Path $Extract 'install.mjs') --root $Root --register-existing}
if($LASTEXITCODE -ne 0){throw 'A instalacao informou uma pendencia. Preserve a mensagem e diagnostique; nao repita em loop.'}
if(Test-Path -LiteralPath (Join-Path $Root 'installation.json')){
 & (Join-Path $Root 'runtime/node.exe') (Join-Path $Root 'doctor.mjs')
 if($LASTEXITCODE -ne 0){throw 'Dependencias ainda nao estao prontas.'}
 & (Join-Path $Root 'runtime/node.exe') (Join-Path $Root 'connection.mjs') --connect
 if($LASTEXITCODE -ne 0){Write-Host 'Instalado; falta confirmar o painel no Premiere. Leia readiness.json. Nao altere a timeline.';exit 2}
}
