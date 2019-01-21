# specify which computer names to stop the services on from a text file
$workstations = Get-Content c:\src\computername.txt

# specify which services to stop from a text file
$services = Get-Content c:\src\services.txt

# stop services recursively using ServiceName (check back on textfile)
Get-Service -ServiceName $services -Computer $workstations |
    Set-Service -StartupType disabled -PassThru |
    Stop-Service -PassThru -ea 0