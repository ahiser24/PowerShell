#This script will get a list of all sites in a tenant which contain the SPO group "Everyone Except External Users" in the Members and Visitors SPO group and export the list to a CSV file. It will then remove the group and add a new group in it's place. Useful for replacing with a dynamic group for Internal users.
#Note - You need to update the TENANT, $everyoneUser = The "Everyone Except External User" group and guid, $usertoAdd = What group/user to replace it with.
#Connect to SharePoint Online
Connect-SPOService -Url https://TENANT-admin.sharepoint.com

#Get all site collections
$siteCollections = Get-SPOSite -Limit All

#Initialize progress bar
$progress = 0

#Prepare CSV export
$results = @()

foreach ($site in $siteCollections) {
    $siteTitle = $site.Title
    $groupVisitors = $siteTitle + " Visitors"
    $groupMembers = $siteTitle + " Members"
    $everyoneUser = "spo-grid-all-users/8d0133b7-55da-4532-882f-4964a77d21fd"
    $removeUser = "c:0-.f|rolemanager|" + $everyoneUser
    $userToAdd = "test.user@TENANT.onmicrosoft.com"

    try {
        # Get SharePoint groups
        $spGroupVisitors = Get-SPOSiteGroup -Site $site.Url -Group $groupVisitors
        $spGroupMembers = Get-SPOSiteGroup -Site $site.Url -Group $groupMembers

        # Check if user exists in users field
        $userInVisitors = $spGroupVisitors.Users -contains $everyoneUser
        $userInMembers = $spGroupMembers.Users -contains $everyoneUser

        # Add result to CSV export array
        $results += New-Object PSObject -Property @{
            'URL' = $site.Url
            'Visitors' = $userInVisitors
            'Members' = $userInMembers
            'Error' = $null
        }

        if ($userInVisitors) {
            # Add user "John.Doe@tenant.com" to the Visitors group with READ permission
            Add-SPOUser -Site $site.Url -LoginName $userToAdd -Group $groupVisitors
            
            # Remove the "Everyone Except External Users" group from Visitors
            Remove-SPOUser -Site $site.Url -LoginName $removeUser -Group $groupVisitors
        }
        
        if ($userInMembers) {
            # Remove the "Everyone Except External Users" group from Members
            Add-SPOUser -Site $site.Url -LoginName $userToAdd -Group $groupVisitors
            Remove-SPOUser -Site $site.Url -LoginName $removeUser -Group $groupMembers
        }
    }
    catch {
        # Catch errors and add them to the CSV export array
        $results += New-Object PSObject -Property @{
            'URL' = $site.Url
            'Visitors' = $null
            'Members' = $null
            'Error' = $_.Exception.Message
        }
    }

    # Update progress bar
    Write-Progress -Activity "Checking site collections" -Status "$progress out of $($siteCollections.Count)" -PercentComplete (($progress / $siteCollections.Count) * 100)
    $progress++
}

# Export results to CSV
$results | Export-Csv -Path C:\temp\SPusers.csv -NoTypeInformation

Write-Host "Script completed. Results exported to SPusers.csv."
