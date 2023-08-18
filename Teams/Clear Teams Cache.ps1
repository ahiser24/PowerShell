##This script will clear the cache for Microsoft Teams. It will first close out of Teams and Outlook and remove the necessary folders that contain the cache in Teams. It will then restart Teams and Outlook for the user.

#Microsoft Teams .EXE Path
$TeamsPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, 'Microsoft', 'Teams', 'Current', 'Teams.exe')

#Microsoft Teams Cache Folders
$TeamsCache = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft', 'Teams')


#Check if the Path exists for Microsoft Teams Cache
Write-Host 'Scanning for Teams Cache folders'
$Teams = Test-Path $TeamsCache
IF ($Teams = "True")
    {
    Write-Host "Teams Cache Found. Preparing to Delete."
    }
ELSE {
        Write-Host "Teams Cache could not be found. Teams may not be installed." -ErrorAction Stop
        }

#Stop Teams and Outlook processes
Write-Warning -Message 'Teams and Outlook will close in 10 seconds. Press CTRL+C to stop the script.'
Start-Sleep -Seconds 10
Stop-Process -Name Teams -ErrorAction SilentlyContinue
Stop-Process -Name OUTLOOK -ErrorAction SilentlyContinue
Start-Sleep -Seconds 10

#Delete cache files & folders
Remove-Item -path "$TeamsCache\*" -Recurse -ErrorAction SilentlyContinue


Sleep -Seconds 5
Write-Host 'Teams Cache has been deleted. Restarting Teams and Outlook'

#Start Teams and Outlook

Start-Process -File "$($env:USERPROFILE)\AppData\Local\Microsoft\Teams\Update.exe" -ArgumentList '--processStart "Teams.exe"'
Start-Process OUTLOOK.EXE
exit