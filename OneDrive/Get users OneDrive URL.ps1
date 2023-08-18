Connect-PnPOnline -Url https://mosaicco-admin.sharepoint.com -UseWebLogin
$email = Read-Host "What is the user's email address?"
$OneDriveUrl = Get-PnPUserProfileProperty -Account $email | select PersonalURL
$Url = $OneDriveUrl.PersonalUrl
Write-Host "The OneDrive address is: $Url/_layouts/15/onedrive.aspx"