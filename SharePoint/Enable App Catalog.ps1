$URL = 'https://TENANT-admin.sharepoint.com'
Connect-SPOService -Url $URL
$site = Read-Host 'Enter Full Site URL'
Add-SPOSiteCollectionAppCatalog -Site $site
