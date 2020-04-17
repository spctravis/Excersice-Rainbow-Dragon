$IpAddress = '10.0.3.2'
$DefaultGW = '10.0.3.1'
$InterfaceAlias = "Ethernet0"
$dnsAddress = '127.0.0.1'
Rename-Computer -NewName "Finance-DC-1"
New-NetIPAddress -IPAddress $IpAddress -InterfaceAlias $InterfaceAlias -DefaultGateway $DefaultGW -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $dnsAddress
Set-NetConnectionProfile -InterfaceAlias $InterfaceAlias -NetworkCategory Private 
Restart-Computer 