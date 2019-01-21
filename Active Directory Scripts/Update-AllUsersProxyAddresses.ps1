Import-Module ActiveDirectory
$Domains = "loewshotels.com"
$ou = "OU=RSH DEPTS,OU=RSH,OU=HOTEL PROPERTIES,DC=CRP,DC=LOEWSHOTELS,DC=COM"
Get-ADuser -Filter * -SearchBase $ou -properties mail | foreach-object {
    $Proxies = "SIP:$($_.givenname).$($_.surname)@$Domain"
    $_ | Set-ADuser -Add @{ProxyAddresses = $Proxies}
}