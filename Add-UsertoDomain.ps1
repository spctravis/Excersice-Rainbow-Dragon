$department = "IT Dept"
Get-PSSession | Remove-PSSession
$session = New-PSSession -ComputerName DC1 
#AD Must be running
$first = ("Sam", "Abe", "Alf","Dru","Ean","Ern","Jim","Jud","Kam","Ken","Kit","Law","Loy","Lou","Mio","Moe","Nat","Nic","Oak","Obe","Odo","Adi","Ame","Amy","Ann","Ari","Bev","Bai","Dai","Ell","Emy","Ema","Gin","Ima","Jil","Kat","Jet")
$last = ("Hall","King","Hill","Cook","Bell","Diaz","Gray","Cruz","Long","Ling","Wood","Rice","Ross","West","Cole","Ford","Rose","Lowe","Ray","Dean","Chen","Wade","Neal","Neil","Kaz","Knox","")
$users = 1..8 | foreach {
 $f = $first[(Get-Random $first.Count)]
 $m = [char] (65 + (Get-Random 26))
 $l = $last[(Get-Random $last.Count)]
 $firstname = $f
 $lastname = $l
 $username = $f+"."+$l
 $password = "H0n3yH0n3y!!" | ConvertTo-SecureString -AsPlainText -Force
 $ADUsers = @{
    Name = "$firstname $lastname"
    Department = $department
    Enabled = $true
    PasswordNeverExpires = $true
    SamAccountName = $username
    UserPrincipalName = "$Username@DWH.Idaho"
    AccountPassword = $password
    
    }


Invoke-Command -Session $session -ArgumentList $firstname,$lastname,$username,$password -ScriptBlock {

new-aduser `
    -Name $firstname + ' ' + $lastname `
    -Department $department `
    -Enabled $true `
    -PasswordNeverExpires $true `
    -SamAccountName $username `
    -UserPrincipalName "$Username@DWH.Idaho" `
    -AccountPassword $password
}# end scriptblock

}