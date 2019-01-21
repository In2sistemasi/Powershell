$immutableId = Get-Content "c:\src\immutableid.txt"
$tenant = "@loewshotels.onmicrosoft.com"
$newTenant = "@loewshotels.com"

ForEach ($id in $immutableId) {

$user = Get-MsolUser -All | where {$_.ImmutableId -eq $id}

$newUPN = $user.UserPrincipalName.SubString(0,$user.UserPrincipalName.IndexOf("@"))+$tenant 
$newestUPN = $user.UserPrincipalName.SubString(0,$user.UserPrincipalName.IndexOf("@"))+$newTenant

Write-Host "Current UPN:" $user.UserPrincipalName
Write-Host "Changed To: " $newUPN
Write-Host "Then Changed To: " $newestUPN

Set-MsolUserPrincipalName -UserPrincipalName $user.UserPrincipalName -NewUserPrincipalName $newUPN | Out-Null
Set-MsolUserPrincipalName -UserPrincipalName $user.UserPrincipalName -NewUserPrincipalName $newestUPN | Out-Null

Write-Host
}
