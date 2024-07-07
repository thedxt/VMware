# VMware

## VM Copy Paste Enabler
PowerCLI script to enable copy paste on VMWare VMs

It makes the same changes that are listed here https://kb.vmware.com/s/article/57122

[More detailed documentation](https://thedxt.ca/2021/07/vmware-copy-paste-enabler/)

Things to note
* Change `vm_Name` varriable to the VM you want to enable copy paste on
* if the VM is on it will turn it off and make the changes then turn it back on (this may error if you don't have VMware tools installed)
* if the VM is off it will just make the changes
* you'll need to connect to VCSA before running the script

## vCenter ESXi Config Backup
VMware PowerCLI script to backup ESXi host configs using vCenter.

> [!IMPORTANT]
> `folder` must be defined as this is the location the backups will be saved.
> 
> `vcenter` must be defined as this is the vCenter sever the script will use.

* The backup folder is created if it doesn't exist.
* Connection to vCenter defaults to not connected and will prompt for credentials.
* Performs an ESXi config backup for all ESXi hosts in vCenter
* Renames the backup file to have the ESXi hostname, the ESXi installed version with build number, and the local time the backup was taken.

[More detailed documentation](https://thedxt.ca/)

> [!TIP]
> ## Examples
> You will be prompted for vCenter credentials
>  
> `esxi-conf-backup -vcenter "vcenter.contoso.com" -folder "C:\ESXi-Backup"`
>
>
> You can suppress the prompt for vCenter credentials by setting `connected` to `Yes`
> 
> `esxi-conf-backup -vcenter "vcenter.contoso.com" -folder "C:\ESXi-Backup" -connected Yes`
>
