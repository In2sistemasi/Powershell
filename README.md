# Powershell

Skripte se pokreću direktno s računala na slijedeći način:

1. Kreiraj variablu
PS $ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/tomarbuthnot/Run-PowerShell-Directly-From-GitHub/master/Run-FromGitHub-SamplePowerShell.ps1

2. Invoke variable
PS Invoke-Expression $($ScriptFromGithHub.Content)
