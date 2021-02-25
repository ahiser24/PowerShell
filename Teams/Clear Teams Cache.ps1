##This script will clear the cache for Microsoft Teams. It will first close out of Teams and Outlook and remove the necessary folders that contain the cache in Teams. It will then restart Teams and Outlook for the user.

#Microsoft Teams .EXE Path
$TeamsPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, 'Microsoft', 'Teams', 'Current', 'Teams.exe')

#Microsoft Teams Cache Folders
$TeamsCache1 = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft', 'Teams', 'Application Cache', 'Cache')
$TeamsCache2 = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft', 'Teams', 'blob_storage')
$TeamsCache3 = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft', 'Teams', 'Cache')
$TeamsCache4 = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft', 'Teams', 'GPUCache')
$TeamsCache5 = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft', 'Teams', 'IndexedDB')
$TeamsCache6 = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft', 'Teams', 'databases')
$TeamsCache7 = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft', 'Teams', 'Local Storage')
$TeamsCache8 = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft', 'Teams', 'tmp')


#Check if the Path exists for Microsoft Teams Cache
Write-Host 'Scanning for Teams Cache folders'
$Teams = Test-Path "%appdata%\Microsoft\Teams"
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

#Delete cache files & folders
Remove-Item -path "$TeamsCache1\*" -Recurse -ErrorAction SilentlyContinue
Remove-Item -path "$TeamsCache2\*" -Recurse -ErrorAction SilentlyContinue
Remove-Item -path "$TeamsCache3\*" -Recurse -ErrorAction SilentlyContinue
Remove-Item -path "$TeamsCache4\*" -Recurse -ErrorAction SilentlyContinue
Remove-Item -path "$TeamsCache5\*" -Recurse -ErrorAction SilentlyContinue
Remove-Item -path "$TeamsCache6\*" -Recurse -ErrorAction SilentlyContinue
Remove-Item -path "$TeamsCache7\*" -Recurse -ErrorAction SilentlyContinue
Remove-Item -path "$TeamsCache8\*" -Recurse -ErrorAction SilentlyContinue

Sleep -Seconds 5
Write-Host 'Teams Cache has been deleted. Restarting Teams and Outlook'

#Start Teams and Outlook
Start-Process $TeamsPath -ErrorAction SilentlyContinue
Start-Process OUTLOOK.EXE
exit