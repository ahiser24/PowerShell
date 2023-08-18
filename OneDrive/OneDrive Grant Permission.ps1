#This script grants permission for a user to have access to someone else's OneDrive. It will prompt for the email address of the user as well as who the new admin will be for that account.

#SharePoint Admin URL
$URL = "https://mosaicco-admin.sharepoint.com/"

#Connect to SharePoint
Connect-SPOService -URL $URL

#User and new Admin
$SecondaryAdmin = Read-Host "What is the email address for the secondary admin?"
$email = Read-Host "What is the email address for OneDrive user in question?"


#Get proper URL for OneDrive
$OneDrive = $email.Replace(".","_").Replace("@","_")
$url = "https://mosaicco-my.sharepoint.com/personal/" + "$OneDrive"
$url

#Set secondary admin
Set-SPOUser -Site $url -LoginName $SecondaryAdmin -IsSiteCollectionAdmin $true

#Verify secondary admin is set
Get-SPOUser -Site $url -LoginName $email |fl
