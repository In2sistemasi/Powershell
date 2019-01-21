$acl = New-Object System.Security.AccessControl.DirectorySecurity
$acl.SetOwner([System.Security.Principal.NTAccount]'BUILTIN\Administrators')
(Get-Item "C:\PATH_TO_DIRECTORY").SetAccessControl($acl)
