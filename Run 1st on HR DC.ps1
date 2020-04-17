$IpAddress = 10.0.2.2
$DefaultGW = 10.0.2.1
$InterfaceAlias = "Ethernet"
$dnsAddress = 127.0.0.1
Rename-Computer -NewName "HR-DC-1"
New-NetIPAddress -IPAddress $IpAddress -InterfaceAlias $InterfaceAlias -DefaultGateway $DefaultGW -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $dnsAddress
Set-NetConnectionProfile -InterfaceAlias Ethernet -NetworkCategory Private 
Restart-Computer 