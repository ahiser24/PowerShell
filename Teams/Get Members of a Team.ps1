Connect-MicrosoftTeams
$global:Team = Read-Host "What is the name of the Team?"

Function ListGroupId {
    Get-Team -DisplayName $global:Team | select -Property GroupId, DisplayName, Description | Out-GridView
    }

Function EnterGroupId {

    $global:GroupID = Read-Host "Copy and Paste the GroupId of the correct Team"
    $global:GroupID.Substring(0,36)
    }

Function Save-File ([string]$initialDirectory) {

	$SaveInitialPath = "C:\temp\"
	$SaveFileName = "Result.csv"

    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
    $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $OpenFileDialog.initialDirectory = $SaveInitialPath
    $OpenFileDialog.filter = "CSV (*.csv)| *.csv"
	$OpenFileDialog.FileName = $SaveFileName
    $OpenFileDialog.ShowDialog() | Out-Null

    return $OpenFileDialog.filename

}

$SaveMyFile = Save-File


    ListGroupId 
    Write-Host "Please review the Team(s) above and copy the GroupId of the correct Team."
    EnterGroupId

#Export list to CSV
Get-TeamUser -GroupId $global:GroupID.Substring(0,36) | Export-Csv -Path $SaveMyFile