#Connect to SharePoint Online
Connect-SPOService -Url https://mosaicco-admin.sharepoint.com


#Get all site collections
$siteCollections = Get-SPOSite -Limit All

#Your admin account
$adminAccount = "adm-ahiser@mna.corp.mosaicco.com"

#Prepare CSV export
$failedSites = @()

#Initialize progress bar
$progress = 0

foreach ($site in $siteCollections) {
    try {
        #Add your admin account as an admin to the site collection
        Set-SPOUser -Site $site.Url -LoginName $adminAccount -IsSiteCollectionAdmin $true
        Write-Host "Successfully added $adminAccount as an admin to $($site.Url)."
    }
    catch {
        Write-Host "Failed to add $adminAccount as an admin to $($site.Url). Error: $($_.Exception.Message)"
        
        #Add failed site to CSV export array
        $failedSites += New-Object PSObject -Property @{
            'URL' = $site.Url
            'Error' = $_.Exception.Message
        }
    }

    #Update progress bar
    Write-Progress -Activity "Adding admin to site collections" -Status "$progress out of $($siteCollections.Count)" -PercentComplete (($progress / $siteCollections.Count) * 100)
    $progress++
}

#Export failed sites to CSV
$failedSites | Export-Csv -Path C:\temp\FailedSites.csv -NoTypeInformation

Write-Host "Script completed. Failed sites exported to FailedSites.csv."
