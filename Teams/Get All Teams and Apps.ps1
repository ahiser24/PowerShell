Get-TeamsAppInstallationReport | Export-Csv -Path "C:\Temp\TeamsAppInstallationReport.csv"
function Get-TeamsAppInstallationReport {
<#
.SYNOPSIS
    Generates a report of all Teams apps installed in all teams
.DESCRIPTION
    This function gets all the teams in a tenant and then enumerates through each one to get the Teams apps installed in the team.
.EXAMPLE
    PS C:\> Get-TeamsAppInstallationReport
    Generates a report of all Teams apps installed in all teams
.EXAMPLE
    PS C:\> Get-TeamsAppInstallationReport | Export-Csv -Path "C:\Temp\TeamsAppInstallationReport.csv"
    Generates a report of all Teams apps installed in all teams and exports the output to a csv file.
.OUTPUTS
    PSCustomObject
.NOTES
    This function uses the Get-TeamsAppInstallation cmdlet which uses the Microsoft Graph Beta and is only available in the
    MicrosoftTeams version 1.1.3-preview module.
#>
 

 
    [CmdletBinding()]
    param (
         
    )
     
    begin {
        # Get all teams
        Write-Verbose "Getting all Teams"
        $AllTeams = Get-Team
    }
     
    process {
        # Get all apps in each team
        foreach ($Team in $AllTeams) {
            Write-Verbose "Getting installed Teams app(s) in $($Team.DisplayName)"
            $InstalledApps = Get-TeamsAppInstallation -TeamId $Team.GroupId
             
            foreach ($InstalledApp in $InstalledApps) {
                $Output = [PSCustomObject]@{
                    GroupId                 = $Team.GroupId
                    TeamDisplayName         = $Team.DisplayName
                    DisplayName             = $InstalledApp.DisplayName
                    Version                 = $InstalledApp.Version
                    Id                      = $InstalledApp.Id
                    TeamsAppDefinitionId    = $InstalledApp.TeamsAppDefinitionId
                    TeamsAppId              = $InstalledApp.TeamsAppId
                }
 
                # Write the output to the pipeline
                $Output
            }
        }
    }
     
    end {
         
    }
}