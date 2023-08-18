#Gather team names from a list of group IDs saved to the location below.

#Connect to Teams Admin Center
Connect-MicrosoftTeams

#Pull list of groupids from text file and show Team names
$groupid = Get-Content C:\users\ahiser\downloads\groupid.txt

    ForEach ($group in $groupid) {
        Get-Team -GroupId $group
    }