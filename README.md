# Powershell

Skripte se pokreću direktno s računala na sljedeći način (primjer skripte Run-FromGitHub-SamplePowerShell.ps1) :

1. Kreiraj variablu (svaka skripta mora u url imati raw):
> $ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/In2sistemasi/Powershell/master/Run-FromGitHub-SamplePowerShell.ps1

![Raw](../master/Screenshots/raw.png)

2. Invoke variable:
> Invoke-Expression $($ScriptFromGithHub.Content)
