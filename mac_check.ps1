Import-Module virtualmachinemanager;
Get-SCVMMServer –Computername "(Insert your VMM hostname here)"
$MAC= Read-Host "Mac Address: "
get-vm| Get-VirtualNetworkAdapter | where { $_.MACAddress -eq "$MAC" } | Select Name, MACAddress