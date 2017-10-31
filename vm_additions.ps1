Import-Module virtualmachinemanager;
$VERSION = Read-Host "Enter Numeric Version you would like to check: "
$VMS = get-vm | where { $_.VMAddition -like "$VERSION*" } | where { $_.Status -eq "Running" } | Out-String

foreach ($VM in $VMs)
{
     Shutdown-VM | Set-VM –VM $vm –InstallVirtualizationGuestServices $TRUE -RunAsynchronously | Start-VM | Read-SCVirtualMachine
}