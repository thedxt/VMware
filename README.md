# VMware

## VM Copy Paste Enabler
PowerCLI script to enable copy paste on VMWare VMs

It makes the same changes that are listed here https://kb.vmware.com/s/article/57122

[More detailed documentation](https://thedxt.ca/2021/07/vmware-copy-paste-enabler/)

Things to note
* Change `vm_Name` varriable to the VM you want to enable copy paste on
* if the VM is on it will turn it off and make the changes then turn it back on (this may error if you don't have VMware tools installed)
* if the VM is off it will just make the changes
* you'll need PowerCLI installed [(how to do that)](https://developer.vmware.com/powercli)
* you'll need to connect to VCSA before running the script
