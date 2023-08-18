#Connect to the admin center
Connect-SPOService -Url "https://mosaicco-admin.sharepoint.com/"

#Set the site URL policy to Default Sharing link as Existing Access. Change SITEURL to the SharePoint URL of the Team or site.
Set-SPOSite SITEURL -DefaultLinkToExistingAccess $true