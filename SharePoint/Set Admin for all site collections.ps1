#Variables for processing
$AdminURL = "https://mosaicco-admin.sharepoint.com/"
$AdminName = "ADMIN@mosaicco.com"
 
#Connect to SharePoint Online
Connect-SPOService -url $AdminURL
 
$Sites = Get-SPOSite -Limit ALL
 
Foreach ($Site in $Sites)
{
    Write-host "Adding Site Collection Admin for:"$Site.URL
    Set-SPOUser -site $Site -LoginName $AdminName -IsSiteCollectionAdmin $True
}
