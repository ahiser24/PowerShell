 Write-Host "example: https://TENANT.sharepoint.com/sites/MySharePointSite"
 $SiteURL = Read-Host "Please enter the SharePoint URL"
     
 #Connect to PNP Online
 Connect-PnPOnline –Url $SiteURL -UseWebLogin;
 
Set-PnPPropertyBagValue -key "metadatatimestamp" -value " "
