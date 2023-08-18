<#Generates a spreadsheet of Teams that have been created in the past 7 days by comparing SharePoint sites with the same name that were created. #>
$outputpath = "c:\temp\mosaicco_Teams_created.csv"
$SPOAdminSite = "https://mosaicco-admin.sharepoint.com"
 
$offsetDays = 7 #Enter the number of previous days to report on
 

 
 
if ($null -eq $cred)
{
    $cred = Get-Credential -Message "Enter an account with Teams Administrative credentials"
}
 
try
{
    Connect-MicrosoftTeams -Credential $cred -ErrorAction Stop
    Connect-PnPOnline -Url $SPOAdminSite -UseWebLogin -ErrorAction Stop
    $teams = Get-Team -ErrorAction Stop
    $list = Get-PnPList -Identity "/Lists/DO_NOT_DELETE_SPLIST_TENANTADMIN_AGGREGATED_SITECO" -ErrorAction Stop
    $sites = Get-PnPListItem -List $list -Query `
    "<View><Query><Where><Geq><FieldRef Name='TimeCreated' /><Value Type='DateTime'><Today OffsetDays='-$offsetDays' /></Value></Geq></Where></Query></View>" -ErrorAction Stop
}
Catch
{
    Write-Host "Error Message: $($_.exception.message) - TERMINATING SCRIPT" -ForegroundColor Red
    Return
}
 
 
$Hashtable = @()
 
foreach($team in $teams)
{
    $connectedSPSite = $sites.FieldValues | Where-Object{$_.GroupId -eq $team.GroupId}
    if($connectedSPSite.Count)
    {
 
        $channels = Get-TeamChannel -GroupId $team.GroupId
 
        $users = Get-TeamUser -GroupId $team.GroupId
 
        $owners  = $users | Where-Object{$_.Role -eq "owner"}
 
        $members  = $users | Where-Object{$_.Role -eq "member"}
     
        $guestusers = $users | Where-Object{$_.Role -eq "guest"}
 
        if($team.Archived -eq $false)
        {
            $status = "Active"
        }
 
        if($team.Archived -eq $true)
        {
            $status = "Archived"
        }
 
        $connectedSPSite = $sites.FieldValues | Where-Object{$_.GroupId -eq $team.GroupId}
 
        $Hashtable += New-Object psobject -Property @{
        'DisplayName'           = $team.DisplayName;
        'Channels'              = $channels.Count;
        'Team members'          = $members.count;
        'Created By'            = $connectedSPSite.CreatedBy;
        'Owners'                = $owners.count;
        'Guests'                = $guestusers.count;
        'Privacy'               = $team.Visibility;
        'Status'                = $status;
        'Description'           = $team.Description;
        'Classification'        = $team.Classification
        'Group ID'              = $team.GroupId;
        'MailNickName'          = $team.MailNickName;
        'Connected SP Site'     = $connectedSPSite.SiteUrl;
        'Time Created'          = $connectedSPSite.TimeCreated;
        'Storage Used'          = $connectedSPSite.StorageUsed;
        'Num Of Files'          = $connectedSPSite.NumOfFiles;
        }
    }
 
}
 
 
$Hashtable | Select-Object 'Time Created',DisplayName, Channels, "Created By", "Team members", Owners, Guests, ` 
Privacy, Status, Description, Classification, "Group ID", MailNickName, "Connected SP Site", `
"Storage Used", "Num Of Files" | Export-Csv $outputpath -NoTypeInformation