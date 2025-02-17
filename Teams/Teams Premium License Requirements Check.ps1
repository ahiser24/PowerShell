# Import the latest version of the MS Graph Module
Import-Module Microsoft.Graph.Reports -RequiredVersion "2.19.0"

# Connect to MS Graph with Reports permission
Connect-MgGraph -Scopes "Reports.Read.All"

# Prompt the user to select a time frame
function Get-PeriodID {
    param (
        [string]$promptMessage = "Please enter the number of days for the report (7, 30, 90, or 180): "
    )

    $periodID = $null
    while ($null -eq $periodID) {
        $selectedDays = Read-Host -Prompt $promptMessage

        switch ($selectedDays) {
            "7"   { $periodID = "D7"; break }
            "30"  { $periodID = "D30"; break }
            "90"  { $periodID = "D90"; break }
            "180" { $periodID = "D180"; break }
            default {
                Write-Host "Invalid selection. Please try again." -ForegroundColor Red
            }
        }
    }

    return $periodID
}

# Store the valid period ID
$validPeriodID = Get-PeriodID

# Get the Teams activity count and output to CSV
Get-MgReportTeamUserActivityCount -Period $validPeriodID -OutFile "C:\temp\Activity Report.csv"
Write-Output "Teams Activity Report saved to C:\temp\Activity Report.csv"

# Import the downloaded CSV data
$csvData = Import-Csv "C:\temp\Activity Report.csv"

# Function to prompt for email and search the CSV data
function Get-UserFromCSV {
    param (
        [string]$promptMessage = "Please enter the email address to search for ",
        [Parameter(Mandatory=$true)]
        [object]$csvData
    )

    $userData = $null
    while ($null -eq $userData) {
        $emailToSearch = Read-Host -Prompt $promptMessage
        $userData = $csvData | Where-Object { $_."User Principal Name" -eq $emailToSearch }

        if ($null -eq $userData) {
            Write-Host "Email address not found. Please try again." -ForegroundColor Red
        }
    }

    return $userData
}

# Store the user data from the CSV
$userData = Get-UserFromCSV -csvData $csvData


# Set your requirements to grant a Teams Premium license. 
# In this case, the user needs to host over 10 meetings within 30 days.
# Check the "Meetings Organized Count" and output the result
if ([int]$userData."Meetings Organized Count" -ge 10) {
    Write-Host "This user is qualified for a license." -ForegroundColor Green
    Write-Host "This user has hosted" $userData.'Meetings Organized Count' "meetings."
} else {
    Write-Host "This user is not qualified." -ForegroundColor Red
    Write-Host "This user has hosted" $userData.'Meetings Organized Count' "meetings."
}
