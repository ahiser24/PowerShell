#Config Variable
$SiteURL = "https://TENANT.sharepoint.com/sites/Ent-TestClientServicesIT-Ent2"
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -UseWebLogin;
 
#Get the site collection with ID property
$Site = Get-PnPSite -Includes ID
 
#Get Site Collection ID
Write-host -f Green "Site Collection ID:"$Site.Id
