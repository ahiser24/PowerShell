#This script will connect to SharePoint Admin Center and enable Save as Template for a specific Group Site.

#Enter the SharePoint Site URL
$GroupURL = Read-Host "Enter the SharepointSite URL. Example: https://TENANT.sharepoint.com/sites/MySite"

#Connect to SharePoint Online
Write-Host "Please Enter the Sharepoint Admin URL"
Connect-SPOService

#Set Group Site to
Set-SPOsite $GroupURL -DenyAddAndCustomizePages 0
