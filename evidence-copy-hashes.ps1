# Define paths for the original evidence and the copied evidence folders
$originalFolder = "C:\Users\divya\OneDrive\Desktop\df-mod2-forensic-copy\evidence"
$copyFolder = "C:\Users\divya\OneDrive\Desktop\df-mod2-forensic-copy\evidence-copy"
$outputFile = "C:\Users\divya\OneDrive\Desktop\df-mod2-forensic-copy\hash-comparison-results.txt"

# Initialize an array to store the results
$results = @()

# Get all files from the original evidence folder
$originalFiles = Get-ChildItem -Path $originalFolder -File

# Loop through each original file to calculate and compare hashes
foreach ($file in $originalFiles) {
    # Get the corresponding copy file path
    $copyFilePath = Join-Path -Path $copyFolder -ChildPath $file.Name

    # Initialize an entry for the result
    $resultEntry = [PSCustomObject]@{
        FileName = $file.Name
        OriginalHash = ""
        CopiedHash = ""
        MatchStatus = ""
    }

    # Check if the copy file exists
    if (Test-Path -Path $copyFilePath) {
        # Calculate the hash for the original and the copied file
        $originalHash = (Get-FileHash -Path $file.FullName -Algorithm SHA256).Hash
        $copyHash = (Get-FileHash -Path $copyFilePath -Algorithm SHA256).Hash
        
        # Update the result entry with hashes
        $resultEntry.OriginalHash = $originalHash
        $resultEntry.CopiedHash = $copyHash

        # Compare the hashes and update the match status
        if ($originalHash -eq $copyHash) {
            $resultEntry.MatchStatus = "Match"
            Write-Host "Match: $($file.Name) hashes match."
        } else {
            $resultEntry.MatchStatus = "Mismatch"
            Write-Host "Mismatch: $($file.Name) hashes do not match."
        }
    } else {
        $resultEntry.MatchStatus = "Copy Not Found"
        Write-Host "No corresponding copy found for: $($file.Name)"
    }

    # Add the result entry to the results array
    $results += $resultEntry
}

# Output the results to a single file
$results | Export-Csv -Path $outputFile -NoTypeInformation

# Final summary message
Write-Host "Hash comparison results have been written to: $outputFile"
