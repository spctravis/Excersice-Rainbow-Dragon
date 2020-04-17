Get-PSSession | Remove-PSSession
$session = New-PSSession -ComputerName "HR-DC-1"
Invoke-Command -Session $session -ScriptBlock { Install-WindowsFeature DNS -IncludeManagementTools
Add-DnsServerPrimaryZone -NetworkId 10.0.2.1/24 -ZoneFile "10.0.2.2.in-addr.arp.dns"
Add-DnsServerForwarder -IPAddress 10.237.90.20 -PassThru

Install-WindowsFeature DHCP -includeManagmentTools
netsh dhcp add securitygroups
add-DhcpServerv4Scope -name "HR Scope" -startRange 10.0.2.50 -stopRange 10.0.2.100 -subnetmask 255.255.255.0 -state Active
set-dhcpServerv4Scope -ScopeId 10.0.2.0 -LeaseDuration 1.00:00:00 
set-DhcpServerv4OptionValue -ScopeId 10.0.2.0 -DnsDomain DWH.Idaho -DnsServer 10.0.2.2 -Router 10.0.2.1
add-DhcpServerInDC -DnsName DWH.Idaho -IpAddress 10.0.2.2
1..4 | foreach {Add-Computer -ComputerName $("HR-Windows10-"+$_)}
Restart-Service dhcpserver
    }