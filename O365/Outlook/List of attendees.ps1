#Setup - User copies all users from the "TO" field in Outlook invite and pastes them into a txt file called names.txt.
#The format will look like this "Doe, John <John.Doe@email.com>"

#Reads the text file called names.txt from Downloads folder and converts it to a string
$text_file = Get-Content $env:USERPROFILE\Downloads\names.txt
#Define a string
$text = $text_file.ToString()

#Creates a regular expression to separate name and email address
$pattern = "(?<=<).+?(?=>)"
#Remove Symbols
$names = $text -split $pattern -replace ";" -replace "<" -replace ">"
$emails = $text | Select-String -Pattern $pattern -AllMatches | ForEach-Object {$_.Matches.Value}

#Create columns for Name and Email
$output = @()
for ($i=0; $i -lt $names.Length; $i++) {
$output += [PSCustomObject]@{
    Name = $names[$i]
    Email = $emails[$i]
    }
}
#Exports to a CSV file in the users Downloads folder called output.csv
$output | Export-Csv -Path $env:USERPROFILE\Downloads\output.csv -NoTypeInformation
