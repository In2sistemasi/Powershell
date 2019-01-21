# Get the user's Distinguished Name 
Function Get-DistinguishedName ($strUserName) 
{  
   $searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]'') 
   $searcher.Filter = "(&(objectClass=User)(samAccountName=$strUserName))" 
   $result = $searcher.FindOne() 
 
   Return $result.GetDirectoryEntry().DistinguishedName 
} 
 
 
# Check if the user specified a useraccount 
If ($args[0] -eq $null) 
{ 
    $strUserName = Read-Host "Please enter the user's account name (e.g. nmota)" 
} 
Else 
{ 
    $strUserName = $args[0] 
} 
 
$strDN = Get-DistinguishedName $strUserName 
$strDN