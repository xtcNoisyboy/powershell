function Mac-Check {
[CmdletBinding()]
param(
  [Parameter(Mandatory=$True,
    ValueFromPipeline=$True,
    ValueFromPipelineByPropertyName=$True]
  [string]$hostname,
  [Parameter(Mandatory=$True,
    ValueFromPipeline=$True,
    ValueFromPipelineByPropertyName=$True)]
  [Alias('mac')]
  [string]$mac_address
)
  begin {
    Import-Module virtualmachinemanager
  }
  process {
    Get-SCVMMServer -Computername $hostname
    get-vm | Get-VirtualNetworkAdapter | where { $_.MACAddress -eq "$mac_address"} | Select Name, MACAddress
  }
}

function Stop-Action {
[CmdletBinding()]
  begin {
    Import-Module virtualmachinemanager
  }
  process {
    # Change all SaveVMs to Shutdown Guest OS
    get-vm | where { $_.Status -eq "Running"} | where { $_.StopAction -eq "SaveVM"} |
    ForEach-Object {
      get-vm -name $_.Name | Shutdown-VM | Set-VM -StopAction ShutdownGuestOS | Start-VM
    }
  }
}

function VM-Additions {
[CmdletBinding()]
param(
  [Parameter(Mandatory=$True)]
  [string]$version
)
  begin {
    Import-Module virtualmachinemanager 
  }
  process {
    $VMS = get-vm | where { $_.VMAddition -like "$version*" } | where { $_.Status -eq "Running" } | Out-String 
    foreach ($VM in $VMs) {
      Shutdown-VM | Set-VM –VM $vm –InstallVirtualizationGuestServices $TRUE -RunAsynchronously | Start-VM | Read-SCVirtualMachine
    }  
  }
}
