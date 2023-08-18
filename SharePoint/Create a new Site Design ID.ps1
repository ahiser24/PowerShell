#Connect to SharePoint Online
Connect-SPOService -Url "https://TENANT-admin.sharepoint.com/"

#Enter the Site collection and information for the Site Design
$SiteURL = Read-Host "What is the URL for the site collection?"

#List the current Site Scripts
Write-Host "Here are the current Site Scripts for this site collection"
Get-SPOSiteScript

#List the current Site Designs
Write-Host "Here are the current Site Designs for this site collection"
Get-SPOSiteDesign

#Create a Title and Description for new Site Script and Site Design
$Title = Read-Host "What should the Title of the site be?"
$Description = Read-Host "What should the description of the site be?"

#Gathers the Site collection script and creates a new script and design based on title and description
$extracted = Get-SPOSiteScriptFromWeb -WebUrl $SiteURL -IncludeBranding -IncludeTheme -IncludeRegionalSettings -IncludeSiteExternalSharingCapability -IncludeLinksToExportedItems -IncludedLists ("Shared Documents", "Contractor Drop2", "Lists/Distribution List") 
Add-SPOSiteScript -Title "$Title" -Description "$Description" -Content $extracted
$Select_ID = (Get-SPOSiteScript | where {$_.Title -eq "$Title"}).Id
Write-Host "The Site Script ID is" $Select_ID
Add-SPOSiteDesign -Title "$Title" -WebTemplate "1" -SiteScripts $Select_ID
$Select_Design_ID = (Get-SPOSiteDesign | where {$_.Title -eq "$Title"}).Id
Write-Host "The Site Design ID is" $Select_Design_ID
