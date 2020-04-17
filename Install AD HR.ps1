Get-PSSession | Remove-PSSession
$session = New-PSSession -ComputerName "HR-DC-1"
Invoke-Command -Session $session -ScriptBlock {install-windowsfeature AD-domain-services -includeManagmentTools
#Import-Module ADDSDeployment
Install-ADDSDomainController -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainName "DWH.Idaho" 
    Restart-Computer -Force 
    }