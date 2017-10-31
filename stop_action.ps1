Import-Module virtualmachinemanager;
# Change all SaveVMs to Shutdown Guest OS
get-vm | where { $_.Status -eq "Running"} | where { $_.StopAction -eq "SaveVM"} |
ForEach-Object {
get-vm -name $_.Name | Shutdown-VM | Set-VM -StopAction ShutdownGuestOS | Start-VM }