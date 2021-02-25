Import-Module ActiveDirectory

#Input Network account and new name
#This renames the the proper AD fields
$alias = Read-Host -Prompt 'Input Network Account'
Write-Host "Input New Name for User"
$First = Read-Host -Prompt 'First Name'
$Last = Read-Host -Prompt 'Last Name'
Set-ADUser $alias -DisplayName "$Last $First"
Set-ADUser $alias -GivenName $First
Set-ADUser $alias -Surname $Last
$DistinguishedName = Get-ADUser $alias | Select-Object  -ExpandProperty DistinguishedName
Rename-ADObject -Identity $DistinguishedName -NewName "$Last $First"


#Find current email address listed in AD
$Oldemail = get-aduser $alias -properties mail | select-object -ExpandProperty mail 

#Check if primary SMTP exists in ProxyAddresses
Write-Host "Checking if Primary SMTP Exists"
$Oldprimary = get-aduser $alias -Properties proxyaddresses | % {$_.proxyaddresses | ? {$_.startswith('SMTP')}}

#If there is already a primary SMTP set change it to a non-primary with smtp
#Add in the new Primary SMTP for the name change and routing address
#Set the Email address in AD
If ($Oldprimary) {
Write-Host "Primary SMTP exists. Modifying"
Set-ADUser -Identity $alias -remove @{ProxyAddresses="$Oldprimary"}
Set-ADUser -Identity $alias -Add @{ProxyAddresses="smtp:$Oldemail"}
Set-ADUser -Identity $alias -remove @{ProxyAddresses="smtp:$First.$Last@contoso.com"}
Set-ADUser -Identity $alias -Add @{Proxyaddresses="SMTP:$First.$Last@contoso.com"}
Set-ADUser -Identity $alias -Add @{Proxyaddresses="smtp:$First.$Last@contoso.mail.onmicrosoft.com"}
Set-ADUser $alias -EmailAddress "$First.$Last@contoso.com"
}
Else {
Write-Host "Primary SMTP does NOT exist. Modifying"
Set-ADUser -Identity $alias -Add @{ProxyAddresses="smtp:$Oldemail"}
Set-ADUser -Identity $alias -Add @{Proxyaddresses="SMTP:$First.$Last@contoso.com"}
Set-ADUser -Identity $alias -Add @{Proxyaddresses="smtp:$First.$Last@contoso.mail.onmicrosoft.com"}
Set-ADUser $alias -EmailAddress "$First.$Last@contoso.com"
}
Write-Host "Complete"