if (([ADSI]"LDAP://RootDSE").dnshostname) {
} else {
	Write-Host "Message: This is not a domain controller.";
  	exit 1;
}

try {
	$D = [System.DirectoryServices.ActiveDirectory.Domain]::GetComputerDomain();
  	$Domain = [ADSI]"LDAP://$($D)";
  	$LOD = $Domain.lockoutDuration.Value;
  	$lngDuration = $Domain.ConvertLargeIntegerToInt64($LOD);
} catch {
	Write-Host "ERROR: $($Error[0])";
  	exit 1;
}

if (-$lngDuration -gt [DateTime]::MaxValue.Ticks)
{
    $LockoutTime = 1;
} else {
	$Now = Get-Date;
    $NowUtc = $Now.ToFileTimeUtc();
    $LockoutTime = $NowUtc + $lngDuration;
}

try {
	$Searcher = New-Object System.DirectoryServices.DirectorySearcher;
  	$Searcher.PageSize = 200;
  	$Searcher.Filter = "(&(objectCategory=person)(objectClass=user)" `
    	+ "(lockoutTime>=" + $LockoutTime + "))";
  	$Searcher.PropertiesToLoad.Add("distinguishedName") > $Null;
  	#$Searcher.SearchRoot = "LDAP://" + $Domain.distinguishedName;
	$Searcher.SearchRoot = $Domain;
  	$Results = $Searcher.FindAll();
} catch {
	Write-Host "ERROR: $($Error[0])";
  	exit 1;
}

if ($Results.Count -eq 0) {
 	Write-Host "Message: No locked users found.";
 	Write-Host "Statistic: 0";
 	exit 0;
} else {
	$res = $Searcher.FindAll() | select-object Path | foreach-object { `
  		$spl1 = $_.Path.Tostring().Split("//"); `
  		$spl2 = $spl1[3].Split(","); `
  		$spl3 = $spl2[0].Split("="); `
  		$cu = $spl3[1]; `
  		$users += $cu;
  		$users += " ; ";
	}

	Write-host "Message: Locked out users: $users";
	Write-host "Statistic:" $Results.Count
	exit 0
}