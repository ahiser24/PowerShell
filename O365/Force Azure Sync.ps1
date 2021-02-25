#Connect to O365 Powershell
Connect-MsolService
#Run Azure Sync and wait until complete
Invoke-Command -ComputerName PADFS00 -ScriptBlock {Import-Module ADSync
Start-ADSyncSyncCycle -PolicyType Delta}
Write-Host "Initializing Azure AD Delta Sync..." -ForegroundColor Yellow

#Check until AAD Delta Sync is completed
$lastsync = Get-MSOLCompanyInformation | select -ExpandProperty LastDirSyncTime
Write-Host "Last Sync $time"
$str = Out-String -InputObject $lastsync
Do {
    $newsync = Get-MSOLCompanyInformation | select -ExpandProperty LastDirSyncTime
    Write-Output "Last Sync $newsync"
    $str2 = Out-String -InputObject $newsync
    if ($str -match $str2) {
    Write-Host "Checking for next sync"
    } else {
    Write-Host "Sync time changed from $str to $str2"
    }
    Start-Sleep -Seconds 15
    }
    Until ($str -notmatch $str2)