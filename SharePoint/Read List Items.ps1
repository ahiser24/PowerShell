Connect-SPOService
#Config Variables
$SiteURL="https://mosaicco.sharepoint.com/sites/SITENAME"
$ListName= "LISTNAME"
  
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -UseWebLogin;
  
#PnP powershell to get list items
$ListItems = Get-PnPListItem -List $ListName -PageSize 2000
  
#Iterate through each Item in the list
foreach($ListItem in $ListItems)
{ 
    Write-Host "Title:" $ListItem["Title"]
}
