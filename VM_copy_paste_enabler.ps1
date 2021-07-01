# VM copy paste enabler v1.0.0
# Author: Daniel Keer
# Author URI: https://thedxt.ca
# Script URI: https://github.com/thedxt/VMware

# Change this to the name the VM you want to enable copy paste on
$vm_Name = "YOUR VM NAME HERE"

# info command
$VMInfo = Get-VM -Name $vm_Name

# function to do all of the copy paste enablements
function vmware_copypaste_enable {
# the settings
$copy_check = get-AdvancedSetting -Entity $vm_Name -Name isolation.tools.copy.disable
$paste_check = get-AdvancedSetting -Entity $vm_Name -Name isolation.tools.paste.disable
$GUI_check = get-AdvancedSetting -Entity $vm_Name -Name isolation.tools.setGUIOptions.enable

# check if copy setting has a value and replace or just make it
if($copy_check -ne $null){
write-host "copy setting for $vm_Name has an existing value"
write-host "replacing existing setting to allow copy for $vm_Name"
New-AdvancedSetting -Entity $vm_Name -Name isolation.tools.copy.disable -Value False -Confirm:$false -force | out-null
write-host "copy setting has been enabled for $vm_Name"
}else{
Write-host "no existing copy setting found for $vm_Name"
Write-host "setting the setting to allow copy for $vm_Name"
New-AdvancedSetting -Entity $vm_Name -Name isolation.tools.copy.disable -Value False -Confirm:$false | out-null
write-host "copy setting has been enabled for $vm_Name"
}

# Check if paste setting has a value and replace it or make it
if($paste_check -ne $null){
write-host "paste setting for $vm_Name has an existing value"
write-host "replacing existing setting to allow paste for $vm_Name"
New-AdvancedSetting -Entity $vm_Name -Name isolation.tools.paste.disable -Value False -Confirm:$false -force | out-null
write-host "paste setting has been enabled for $vm_Name"
}else{
Write-host "no existing paste setting found for $vm_Name"
Write-host "setting the setting to allow paste for $vm_Name"
New-AdvancedSetting -Entity $vm_Name -Name isolation.tools.paste.disable -Value False -Confirm:$false | out-null
write-host "paste setting has been enabled for $vm_Name"
}

# Check if copy paste GUI setting has a value and replace it or make it
if($GUI_check -ne $null){
write-host "copy paste GUI setting for $vm_Name has an existing value"
write-host "replacing existing setting to allow copy paste GUI for $vm_Name"
New-AdvancedSetting -Entity $vm_Name -Name isolation.tools.setGUIOptions.enable -Value True -Confirm:$false -force | out-null
write-host "copy paste GUI setting has been enabled for $vm_Name"
}else{
Write-host "no existing copy paste GUI setting found for $vm_Name"
Write-host "setting the setting to allow copy paste GUI for $vm_Name"
New-AdvancedSetting -Entity $vm_Name -Name isolation.tools.setGUIOptions.enable -Value True -Confirm:$false | out-null
write-host "copy paste GUI setting has been enabled for $vm_Name"
}
}

# check if vm is on if on shut it down
 if ($VMInfo.PowerState -eq "PoweredOn")
 {
 Write-Host "Shutting Down $vm_Name"
 Shutdown-VMGuest -VM $vm_Name -Confirm:$false | out-null

# Wait for Shutdown to complete
 do {
  # check the status every 5 seconds
  Start-Sleep -s 5
  $vm_check = Get-VM -Name $vm_Name
  $status = $vm_check.PowerState
 }until($status -eq "PoweredOff")
 Write-Host "$vm_Name is now off"
 write-host "starting the copy paste enablement for $vm_Name"
 vmware_copypaste_enable
 write-host "Copy Paste has been enable for $vm_Name"
 write-host "Turning on $vm_Name"
 start-vm $vm_Name | out-null
} else {
write-host "$vm_Name is already off"
write-host "starting the copy paste enablement for $vm_Name"
vmware_copypaste_enable
write-host "Copy Paste has been enable for $vm_Name"
}
