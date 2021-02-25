Import-Module ActiveDirectory
$email = Get-Content "C:\Users\USER\Downloads\tc1.txt"

	Foreach ($alias in $email) {
    Set-ADUser -Identity $alias -Add @{Proxyaddresses="smtp:$alias@contoso.mail.onmicrosoft.com"}
    } 