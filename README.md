# Powershell

Skripte se pokreću direktno s računala na sljedeći način (primjer skripte Run-FromGitHub-SamplePowerShell.ps1) :

1. Kreiraj variablu (svaka skripta mora u url imati raw):
> $ScriptFromGithHub = Invoke-WebRequest https://raw.githubusercontent.com/In2sistemasi/Powershell/master/Run-FromGitHub-SamplePowerShell.ps1

![Raw](../master/Screenshots/raw.png)

2. Invoke variable:
> Invoke-Expression $($ScriptFromGithHub.Content)

# Visual Studio Extension appears to fail to run PowerShell if execution policy set in GPO, 2.8.6 and 3.0
Problem ako pokrečete skripte is Visual Studio Code i javi grešku:

"Windows PowerShell updated your execution policy successfully, but the setting is overridden by a policy defined at a more specific scope. Due to the override, your shell will retain its current effective execution policy of Unrestricted. Type "Get-ExecutionPolicy -List" to view your execution policy settings. For more information please see "Get-Help Set-ExecutionPolicy"."

Pokrenuti:
>Set-ExecutionPolicy -Scope Process ByPass
