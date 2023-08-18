#Config Parameters
$AdminSiteURL="https://TENANT-admin.sharepoint.com"
$UserAccount = "John.Doe@TENANT.com"
  
#Connect to SharePoint Online Tenant Admin
Connect-SPOService -URL $AdminSiteURL
  
#Get all Site Collections
$SitesCollections = Get-SPOSite -Limit ALL
 
#Iterate through each site collection
ForEach($Site in $SitesCollections)
{
    Start-Sleep -m 500
    Write-host -f Yellow "Checking Site Collection:"$Site.URL
  
    #Get the user from site collection
    $User = Get-SPOUser -Limit All -Site $Site.URL | Where {$_.LoginName -eq $UserAccount}
  
    #Remove the User from site collection
    If($User)
    {
        #Remove the user from the site collection
        Remove-SPOUser -Site $Site.URL -LoginName $UserAccount
        Write-host -f Green "`tUser $($UserAccount) has been removed from Site collection!"
    }
}
