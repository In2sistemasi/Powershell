# Script that will add users to the AD Groups from a CSV file
$groupsFile = "C:\LOCATION_TO_CSV_OR_OTHER_FILE_THAT_HAS_USER_DATA"

# $ErrorLog = Read-host “Enter the full path to the log file”
$ErrorLog = "c:\UserMigration.log"

if (!$ErrorLog) {
    $ErrorLog = "c:\SRC\MFAGroups.log"
}

# Debug
Write-Host 'The errorlog = '$ErrorLog

$date = Get-Date

# Add header to error log
"" | Add-Content $ErrorLog
"" | Add-Content $ErrorLog
"Running LoewsGroupPopulation.ps1 on $date" | Add-Content $ErrorLog
"" | Add-Content $ErrorLog

# Check for existing recipient
#$recip = Get-Recipient -resultsize unlimited | Where-Object {$_.RecipientType -eq 'MailContact'}

# Build the list of users from the file in a string array
foreach ($line in get-content $groupsFile) {

    $split = $line.split(",")

    $location = $split[0]
    $upn = $split[1]

    #split at a certain pattern in the document to normalize the data
    $splitSub = $line.split(" -")
    $sublocation = $splitSub[0]

    # Debug
    Write-Host 'The location = '$location
    "The location = $location" | Add-Content $ErrorLog

    Write-Host 'The upn = '$upn
    "The upn = $upn" | Add-Content $ErrorLog

    Write-Host 'The sublocation = '$sublocation
    "The sublocation = $sublocation" | Add-Content $ErrorLog

    # iterate through the array via switch
    switch ($sublocation) 
    { 
        "DATA_IN_DOCUMENT_IDENTIFYING_STRING" {$group = "GROUP_NAME"} 
        
        default {
            Write-Host "ERROR: The sublocation $sublocation not matched switch entry"
            "ERROR: The sublocation $sublocation not matched switch entry" | Add-Content $ErrorLog
        }
    }
    
    try {
        $user = Get-Aduser -filter 'userprincipalname -eq $upn' -ErrorAction stop
        } catch {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName
            # Debug
            Write-Host 'ERROR:'$_.Exception.Message
            "ERROR:'$_.Exception.Message" | Add-Content $ErrorLog
            Write-Host 'Unable to get user '$upn
            "Unable to get user $upn" | Add-Content $ErrorLog
        }

    if ($user -ne $null) {
        try {
            Add-ADGroupMember -Identity $group -Members $user -ErrorAction Stop
            Write-Host "Added $user to $group"
            "Added $user to $group" | Add-Content $ErrorLog

        } catch {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName
            # Debug
            Write-Host 'ERROR:'$_.Exception.Message
            "ERROR:'$_.Exception.Message" | Add-Content $ErrorLog
            Write-Host "Unable to add user $upn to group $group"
            "Unable to add user $upn to group $group" | Add-Content $ErrorLog
        }
    }

    $split = $null
    $location = $null
    $upn = $null
    $splitSub = $null
    $sublocation = $null
    $user = $null
    $group = $null

    Write-Host ""
    "" | Add-Content $ErrorLog

}