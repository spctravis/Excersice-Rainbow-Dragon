Get-PSSession | Remove-PSSession
$session = New-PSSession -ComputerName DC1 -Credential $cred
Invoke-Command -Session $session -ScriptBlock {install-windowsfeature AD-domain-services -includeManagmentTools
Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode WinThreshold `
    -DomainName "DWH.Idaho" `
    -DomainNetbiosName "Idaho" `
    -ForestMode WinThreshold `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true
    }