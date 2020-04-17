Get-PSSession | Remove-PSSession
$session = New-PSSession -ComputerName "Finance-DC-1"
Invoke-Command -Session $session -ScriptBlock {install-windowsfeature AD-domain-services -IncludeManagementTools
#Import-Module ADDSDeployment
Install-ADDSDomainController -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainName "DWH.Idaho" 
    Restart-Computer -Force 
    }