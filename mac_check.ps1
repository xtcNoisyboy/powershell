Import-Module virtualmachinemanager;
$SCVMM = Read-Host "Enter your VMM Hostname here: "
Get-SCVMMServer –Computername "$SCVMM"
$MAC = Read-Host "Mac Address: "
get-vm| Get-VirtualNetworkAdapter | where { $_.MACAddress -eq "$MAC" } | Select Name, MACAddress