Import-Module ActiveDirectory
$oldSuffix = "hotel1000seattle.com"
$newSuffix = "loewshotels.com"
$ou = "OU=RSH DEPTS,OU=RSH,OU=HOTEL PROPERTIES,DC=CRP,DC=LOEWSHOTELS,DC=COM"
$server = "LHCRPDC01"
Get-ADUser -SearchBase $ou -filter * | ForEach-Object {
$newUpn = $_.UserPrincipalName.Replace($oldSuffix,$newSuffix)
$_ | Set-ADUser -server $server -UserPrincipalName $newUpn
}