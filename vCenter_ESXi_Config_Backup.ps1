# vCenter ESXi Config Backup
# Version 1.0.0
#
# Author: Daniel Keer
# Author URI: https://thedxt.ca
# Script URI: https://github.com/thedxt/VMware
#
# DESCRIPTION
# Backs up each ESXi host in vCenter
#
# EXAMPLE
# esxi-conf-backup -vcenter "vcenter.contoso.com" -folder "C:\ESXi-Backups"

# Main function
function esxi-conf-backup{
param(
[Parameter (Mandatory = $true)] [String]$vcenter,
[Parameter (Mandatory = $true)] [String]$folder,
[Parameter(Mandatory=$false)] [ValidateSet('Yes','No')] [String]$connected
)



# function to check if folder exists if not make it

function folder-check{

if (-not (Test-Path $folder))
{

write-host $folder "Does NOT exist creating it"
New-Item -ItemType Directory $folder | out-null
write-host $folder "has been created"
}else{
write-host $folder "Exists no action needed"
}

}


# Function to connect to vCenter

function connect-vcenter{

if($connected -eq "Yes"){
Write-host "Connected value is Yes."
write-host "no prompt to connect to vCenter will appear"
}else{
write-host "Connected value not set assuming vCenter is not connected."
write-host "prompting to connect to vCenter"
Connect-VIServer -Server $vcenter
}

}


# function to backup the ESXi hosts in vCenter.

function esxi-backup{



Write-host "Starting the backup process"

Write-host "Getting all the ESXi hostnames"

#get all the ESXi hostnames
$hosts = Get-VMHost | select name

#set the date format
$date = get-date -f yyyy-MMM-dd_HHmmss

#loop for each of the ESXi hosts
Foreach ($singlehost in $hosts)

{
#backup to C:\$folder
$backup = Get-VMHostFirmware -VMHost $singlehost.Name -BackupConfiguration -DestinationPath $folder
Write-host "Running backup for" $singlehost.Name

#run the backup but dont output anything to the screen
$backup | out-null
Write-host "Backup completed for" $singlehost.Name


# get the version and build number for the host
Write-host "Getting Version and Build info for" $singlehost.Name
$verinfo = Get-VMHost -Name $singlehost.Name | select Version, Build

# rename the files to have the hostname and version and build number and the date info
Write-host "Fixing the backup file name for" $singlehost.Name
Rename-Item -path $backup.Data.FullName -newname "$($backup.Host.name)_v$($verinfo.Version)_b$($verinfo.Build)_$($date).tgz"
Write-host "Everything is completed for" $singlehost.Name
Write-host "---------------------------"
}

Write-host "The backup process is completed. Backups are located in" $folder
}

#check if connect is defined if not defined assume not connected and connect
connect-vcenter

#check if the folder exists
folder-check

#run the backup
esxi-backup

#end of main function
}
