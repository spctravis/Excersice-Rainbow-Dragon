Get-PSSession | Remove-PSSession
$session = New-PSSession -ComputerName DC1 -Credential $cred
Invoke-Command -Session $session -ScriptBlock { #Install-WindowsFeature DNS -IncludeManagementTools
#Add-DnsServerPrimaryZone -NetworkId 10.0.0.1/24 -ZoneFile "10.0.0.2.in-addr.arp.dns"
#Add-DnsServerForwarder -IPAddress 10.237.90.20 -PassThru

#Install-WindowsFeature DHCP -includeManagmentTools
#netsh dhcp add securitygroups
#add-DhcpServerv4Scope -name "IT Scope" -startRange 10.0.0.50 -stopRange 10.0.0.100 -subnetmask 255.255.255.0 -state Active
#set-dhcpServerv4Scope -ScopeId 10.0.0.0 -LeaseDuration 1.00:00:00 
#set-DhcpServerv4OptionValue -ScopeId 10.0.0.0 -DnsDomain DWH.Idaho -DnsServer 10.0.0.2 -Router 10.0.0.1
#add-DhcpServerInDC -DnsName DWH.Idaho -IpAddress 10.0.0.2
#Restart-Service dhcpserver

1..4 | foreach {Add-Computer -ComputerName $("IT-Windows10-"+$_) -Credential $using:cred -DomainName "dwh.idaho"}
1..4 | foreach {Add-Computer -ComputerName $("Admin-Windows10-"+$_) -Credential $using:cred -DomainName "dwh.idaho"}
    }