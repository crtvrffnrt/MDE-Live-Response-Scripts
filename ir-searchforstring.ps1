# Define search strings
$searchStrings = @(
    'password', 
    'Passwort', 
    'passwörter', 
    'Zugangsdaten', 
    'Kennwörter', 
    'Kennwoerter'
)

# Define output file path
$outputFilePath = 'C:\searchfiles_output.txt'

# Iterate through each drive and search for files matching the search strings
Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    Get-ChildItem -Path $_.Root -Recurse -ErrorAction SilentlyContinue -Depth 5 -File |
    ForEach-Object {
        # Assign the current file to the $file variable
        $file = $_
        # Iterate through each search string and check if it matches the file name or full path
        $searchStrings | ForEach-Object {
            if ($file.FullName -like "*$_*" -or $file.Name -like "*$_*") {
                # If a match is found, write the full path of the file to the output file
                $file.FullName | Out-File -Append -FilePath $outputFilePath
            }
        }
    }
}
