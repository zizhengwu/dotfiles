oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/probua.minimal.omp.json" | Invoke-Expression
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardKillWord
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Import-Module -Name Terminal-Icons
Set-PSReadLineOption -Colors @{
   "Default"   = [ConsoleColor]::Black
   "Parameter" = [ConsoleColor]::Black
   "Type"      = [ConsoleColor]::DarkBlue
   "Number"    = [ConsoleColor]::Magenta
   "String"    = [ConsoleColor]::Magenta
   "Comment"   = [ConsoleColor]::Yellow
   "Variable"  = [ConsoleColor]::Green
   "Keyword"   = [ConsoleColor]::Blue
   "Operator"  = [ConsoleColor]::Blue
   "Command"   = [ConsoleColor]::Blue
   "Member"    = [ConsoleColor]::Blue
   "Error"     = [ConsoleColor]::Red
}
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

$profileDir = Split-Path -Parent $PSCommandPath
. (Join-Path $profileDir 'EditConsoleInput.ps1')
Invoke-Expression (& { (zoxide init powershell | Out-String) })
