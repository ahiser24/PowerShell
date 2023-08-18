#Connect to O365
#Connect-MsolService

#Variables
Write-Host "Input the name of the user"
$alias = Read-Host -Prompt 'Input User'
Write-Host "Input the name of the delegate"
$delegate = Read-Host -Prompt 'Input Delegate User'


#Get Mailbox Permissions
Get-MailboxFolder Permission "$alias":\Calendar

#Add Delegate Permissions
Add-MailboxFolderPermission "$alias":\Calendar -User $delegate -AccessRights Editor -SharingPermissionFlags Delegate
