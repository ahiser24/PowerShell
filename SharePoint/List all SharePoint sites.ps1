Connect-SPOService -Url "https://TENANT-admin.sharepoint.com"
Get-SPOSite -Limit "All" -IncludePersonalSite $True | Export-Csv -Path "C:\temp\SiteListing.csv"
