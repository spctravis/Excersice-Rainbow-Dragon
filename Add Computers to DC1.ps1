$localcred = Get-Credential
Get-PSSession | Remove-PSSession
$session = New-PSSession -ComputerName DC1 -Credential $cred
Invoke-Command -Session $session -ScriptBlock {

1..4 | foreach {Add-Computer -ComputerName $("IT-Windows10-"+$_) -Credential $using:cred -DomainName "dwh.idaho" -LocalCredential $using:localcred -Restart -Force}
#1..4 | foreach {Add-Computer -ComputerName $("Admin-Win10-"+$_) -Credential $using:cred -DomainName "dwh.idaho" -LocalCredential $using:localcred -Restart -Force}

}