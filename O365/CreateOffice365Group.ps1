#Prompt User for name of the O365 Group
$NewGroupName = Read-Host -Prompt "Enter the name of the Distribution Group"

#Create a NO-SPACES variable for $NewGroupName
$NewGroupNameNoSpaces = $NewGroupName.Replace(' ', '')

#Confirm if O365 Group name is correct
Write-Host "You have entered "$NewGroupName""

$choice1 = ""
while ($choice1 -notmatch "[y|n]"){
    $choice1 = read-host "Do you want to continue? (Y/N)"
    }

#If YES create new Office365 group, and add members from C:\scripts\DGExportMembers.csv file.
if ($choice1 -eq "y"){
       New-UnifiedGroup -DisplayName "$NewGroupName" -Alias "$NewGroupNameNoSpaces" -PrimarySMTPAddress $NewGroupNameNoSpaces@badcock.com
       Set-UnifiedGroup "$NewGroupName" -UnifiedGroupWelcomeMessageEnabled:$false
       Start-Sleep -s 5
       Import-CSV "C:\scripts\DGExportMembers.csv" | ForEach-Object {Add-UnifiedGroupLinks –Identity "$NewGroupName" –LinkType Members –Links $_.PrimarySmtpAddress}
       Get-UnifiedGroupLinks -Identity "$NewGroupName" -LinkType Members | FT Name, RecipientType, Primarysmtpaddress
    }

if ($choice1 -eq "n"){exit}
