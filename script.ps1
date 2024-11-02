# Define paths for the original evidence and the copied evidence folders
$originalFolder = "C:\Users\divya\OneDrive\Desktop\df-mod2-forensic-copy\evidence"
$copyFolder = "C:\Users\divya\OneDrive\Desktop\df-mod2-forensic-copy\evidence-copy"

# Get all files from the original evidence folder
$originalFiles = Get-ChildItem -Path $originalFolder -File

# Initialize a flag to check if all hashes match
$allHashesMatch = $true

# Loop through each original file to calculate and compare hashes
foreach ($file in $originalFiles) {
    # Get the corresponding copy file path
    $copyFilePath = Join-Path -Path $copyFolder -ChildPath $file.Name

    # Check if the copy file exists
    if (Test-Path -Path $copyFilePath) {
        # Calculate the hash for the original and the copied file
        $originalHash = (Get-FileHash -Path $file.FullName -Algorithm SHA256).Hash
        $copyHash = (Get-FileHash -Path $copyFilePath -Algorithm SHA256).Hash

        # Compare the hashes
        if ($originalHash.Substring(0, 10) -eq $copyHash.Substring(0, 10)) {
            Write-Host "Match: $($file.Name) hashes match."
        } else {
            Write-Host "Mismatch: $($file.Name) hashes do not match."
            $allHashesMatch = $false
        }
    } else {
        Write-Host "No corresponding copy found for: $($file.Name)"
        $allHashesMatch = $false
    }
}

# Check overall results
if ($allHashesMatch) {
    Write-Host "All hashes match. You have a forensically sound evidence-copy folder."
} else {
    Write-Host "Some hashes did not match. Please re-copy the evidence and calculate new hashes."
}

