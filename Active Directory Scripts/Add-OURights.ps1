Import-Module ActiveDirectory
#Bring up an Active Directory command prompt so we can use this later on in the script
Set-Location ad:
#Get a reference to the RootDSE of the current domain
$rootdse = Get-ADRootDSE
#Get a reference to the current domain
$domain = Get-ADDomain


#Create a hashtable to store the GUID value of each schema class and attribute
$guidmap = @{}
Get-ADObject -SearchBase ($rootdse.SchemaNamingContext) -LDAPFilter `
"(schemaidguid=*)" -Properties lDAPDisplayName,schemaIDGUID | 
% {$guidmap[$_.lDAPDisplayName]=[System.GUID]$_.schemaIDGUID}
#Create a hashtable to store the GUID value of each extended right in the forest
$extendedrightsmap = @{}
Get-ADObject -SearchBase ($rootdse.ConfigurationNamingContext) -LDAPFilter `
"(&(objectclass=controlAccessRight)(rightsguid=*))" -Properties displayName,rightsGuid | 
% {$extendedrightsmap[$_.displayName]=[System.GUID]$_.rightsGuid}


#Initialize an array of code names for our loop iterations if you have multiple OUs
$ouPrefixNames = @("BSC", "CBR", "LBB", "LHH", "CHI", "ANP", "ATL", "MIN")

#Iterate through all the strings in the hotelnames array
foreach($name in $ouPrefixNames) {
$ou = Get-ADOrganizationalUnit -Identity ("OU=TARGET OU,OU=$name` GROUPS,OU=$name`,OU=PARENT OU,"+$domain.DistinguishedName)
#Get the SID values of each group to delegate access to
$bscadmin = New-Object System.Security.Principal.SecurityIdentifier (Get-ADGroup "BSCHOTELS_Service Desk Admins").SID
$bscanalyst = New-Object System.Security.Principal.SecurityIdentifier (Get-ADGroup "BSCHOTELS_Service Desk Analyst").SID
$hoteladmin = New-Object System.Security.Principal.SecurityIdentifier (Get-ADGroup "$hotel`_Hotel Administrators").SID
#Get a copy of the current DACL on the OU
$acl = Get-ACL -Path ($ou.DistinguishedName)


#############################################################################################################################
# THIS ACCESS RULE WILL GIVE RIGHTS TO MODIFY GROUP MEMBERSHIP ONLY, YOU WILL NEED TO LOOK ON AD/ADVANCED SECURITY SETTINGS #
# OF AN OU TO DETERMINE THE RIGHTS YOU WANT TO ASSIGN TO THE USERS/GROUPS                                                   #
#############################################################################################################################
#Create an Access Control Entry for new permission we wish to add
#Allow the group to write all properties of descendent user objects
$acl.AddAccessRule((New-Object System.DirectoryServices.ActiveDirectoryAccessRule `
$bscadmin,"WriteProperty","Allow","Descendents",$guidmap["group"]))
#Allow the group to create and delete user objects in the OU and all sub-OUs that may get created
$acl.AddAccessRule((New-Object System.DirectoryServices.ActiveDirectoryAccessRule `
$bscadmin,"ReadProperty, WriteProperty","Allow",$guidmap["group"],"All"))
#Re-apply the modified DACL to the OU
Set-ACL -ACLObject $acl -Path ("AD:\"+($ou.DistinguishedName))
$acl.AddAccessRule((New-Object System.DirectoryServices.ActiveDirectoryAccessRule `
$bscanalyst,"WriteProperty","Allow","Descendents",$guidmap["group"]))
#Allow the group to create and delete user objects in the OU and all sub-OUs that may get created
$acl.AddAccessRule((New-Object System.DirectoryServices.ActiveDirectoryAccessRule `
$bscanalyst,"ReadProperty, WriteProperty","Allow",$guidmap["group"],"All"))
#Re-apply the modified DACL to the OU
Set-ACL -ACLObject $acl -Path ("AD:\"+($ou.DistinguishedName))
$acl.AddAccessRule((New-Object System.DirectoryServices.ActiveDirectoryAccessRule `
$hoteladmin,"WriteProperty","Allow","Descendents",$guidmap["group"]))
#Allow the group to create and delete user objects in the OU and all sub-OUs that may get created
$acl.AddAccessRule((New-Object System.DirectoryServices.ActiveDirectoryAccessRule `
$hoteladmin,"ReadProperty, WriteProperty","Allow",$guidmap["group"],"All"))
#Re-apply the modified DACL to the OU
Set-ACL -ACLObject $acl -Path ("AD:\"+($ou.DistinguishedName))
}