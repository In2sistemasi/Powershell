# Powershell

Skripte se pokreću direktno s računala na slijedeći način:

1. Kreiraj variablu:
> $ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/In2sistemasi/Powershell/master/Run-FromGitHub-SamplePowerShell.ps1

2. Invoke variable:
> Invoke-Expression $($ScriptFromGithHub.Content)
