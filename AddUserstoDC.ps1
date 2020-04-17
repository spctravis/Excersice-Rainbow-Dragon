$department = "IT"
Get-PSSession | Remove-PSSession
$session = New-PSSession -ComputerName DC1 
#AD Must be running

1..30 | foreach {
 $f = $first[(Get-Random $first.Count)]
 $m = [char] (65 + (Get-Random 26))
 $l = $last[(Get-Random $last.Count)]
 $firstname = $f
 $lastname = $l
 $username = $f+"."+$l
 $identity = "Users"
 $password = $l+"11!!"
 $department = $department
 $ou = "CN=Users,DC=DHW,DC=Idaho"
 $ADUsers += @{
    Firstname = $firstname
    Lastname = $lastname
    Username = $username
    Identity = $identity
    Password = $password
    Department = $department
    OU = $ou 
    }

} #end foreach

#Install ADUsers
Invoke-Command -Session $session -ScriptBlock {



foreach ($User in $Using:ADUsers)

{

    #Runs check against AD to verify User doesn't already exist inside of Active Directory

    if (Get-ADUser -F {SamAccountName -eq $Username })
    {
         Write-Warning "$Username already exists."
    }


#If User doesn't exist, New-ADUser will add $Username to AD based on the objects specified specified in the .csv file. 

    else


    {
        #Update to UserPrincipalName to match personal domain. Ex: If domain is: example.com. Should read as - $Username@example.com
        
        New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@DHW.Idaho" `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -Department $Department `
            -Enabled $True `
            -DisplayName "$firstname $lastname" `
            -Path $ou `
            -AccountPassword (convertto-securestring $password -AsPlainText -Force) -PasswordNeverExpires $True `
            -PassThru | Enable-ADAccount
            

           Add-ADGroupMember `
           -Members $username `
           -Identity $identity `
	    }
         Write-Output "$username has been added to the domain and added to the $identity group"
    }
#setspn -a glamdring/shire.com shire\gandalf

}