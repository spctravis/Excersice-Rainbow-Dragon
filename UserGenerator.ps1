$department = "IT"
$users = @()
$first = "Noah Sophia Liam Emma Jacob Olivia Mason Isabella William Ava Ethan Mia Michael Emily Alexander Abigail Jayden Madison Daniel Bob Jim Jake Jill George Mike Robert Cora Erik Eric".Split(" ")
$last = "Smith Johnson Williams Brown Jones Miller Davis Garcia Rodriguez Wilson Martines Anderson Taylor Thomas Hernandex Moore Martin Jackson Thompson White Wyatt Clark White Knox Brandon Erickson".split(" ")

1..30 | foreach {
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

    #Runs check against AD to verify User doesn't already exist inside of Active Directory

    if (Get-ADUser -F {SamAccountName -eq $Username })
    {
         Write-Warning "$Username already exists."
    }


#If User doesn't exist, New-ADUser will add $Username to AD based on the objects specified specified in the .csv file. 

    else


    {
        #Update to UserPrincipalName to match personal domain. Ex: If domain is: example.com. Should read as - $Username@example.com
        
        New-ADUser @ADUsers `

	    }
         Write-Output "$_.username has been added to the domain and added to the $_.identity group"
    }