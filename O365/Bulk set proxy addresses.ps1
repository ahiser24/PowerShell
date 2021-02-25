Import-Module ActiveDirectory
$email = Get-Content "C:\Users\anhi80831\Downloads\tc1.txt"

	Foreach ($alias in $email) {
    Set-ADUser -Identity $alias -Add @{Proxyaddresses="smtp:$alias@badcock.mail.onmicrosoft.com"}
    } 