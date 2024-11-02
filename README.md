# DF-Mod2 Forensic Copy
## Introduction
This repository documents the process of creating a forensic copy of evidence files from a suspect's computer using PowerShell commands and hashing techniques. The goal is to maintain the integrity of the original evidence while ensuring that any modifications to the copies can be detected.

## Process Overview
1. **Create Evidence Directory**: A directory named `evidence` was created to store multiple evidence files.
2. **Add Example Files**: Five evidence files named `Evidence1`, `Evidence2`, `Evidence3`, `Evidence4`, and `Evidence5` were added to the evidence folder located at `C:\Myproject\df-mod2-forensic-copy1-1`.
3. **Calculate SHA256 Hashes**: The SHA256 hashes of each evidence file were calculated and stored separately.
4. **Copy Evidence Folder**: The `evidence` folder was copied to a new folder named `evidence-copy` for further processing.
5. **Verify Hashes**: The hashes for each file in the `evidence-copy` folder were calculated and compared with the original hashes to ensure they match.

## File and Hash Details
### Original Evidence Files and Hashes
| File Name           | SHA256 Hash                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| Evidence1           | `32139C4FAE534CFAC858C69C52A93F7E85128EEA23E39489BF2876187EC51BC8`       |
| Evidence2           | `6A068959CFD7C3066B1F9AE3FA85F6A7DC3DF77A6F747DFBD07FB2FAD9216157`       |
| Evidence3           | `784636241818ACB1331A792EDCB4BE6311C9FBAEF74061C6DE9DA312150DE52D`      |
| Evidence4           | `AE17FED26862B04536D37FD86995EA3147E94F3B96A864693C1DEC120F23FF43`      |
| Evidence5           | `FB1BD82537CBE735E0DB9D99982BDDF68D827247E54F8C3182ECBE480660B88B`      |

### Forensic Copy Files and Hashes
| File Name           | SHA256 Hash                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| Evidence1           | `32139C4FAE534CFAC858C69C52A93F7E85128EEA23E39489BF2876187EC51BC8`       |
| Evidence2           | `6A068959CFD7C3066B1F9AE3FA85F6A7DC3DF77A6F747DFBD07FB2FAD9216157`       |
| Evidence3           | `784636241818ACB1331A792EDCB4BE6311C9FBAEF74061C6DE9DA312150DE52D`      |
| Evidence4           | `AE17FED26862B04536D37FD86995EA3147E94F3B96A864693C1DEC120F23FF43`      |
| Evidence5           | `FB1BD82537CBE735E0DB9D99982BDDF68D827247E54F8C3182ECBE480660B88B`      |

### Verification Results
All hashes match between the original evidence files and the forensic copy, confirming the integrity of the forensic copy.

## PowerShell Commands
Below are the key PowerShell commands utilized in this process:

```powershell
# Create Evidence Directory
New-Item -ItemType Directory -Path C:\Myproject\df-mod2-forensic-copy1-1\evidence

# Add Files to Evidence Directory (ensure to copy actual files from your local path)
Copy-Item -Path C:\Myproject\df-mod2-forensic-copy1-1\* -Destination C:\Myproject\df-mod2-forensic-copy1-1\evidence

# Calculate SHA256 Hashes for Evidence Files
Get-FileHash -Path C:\Myproject\df-mod2-forensic-copy1-1\evidence\* -Algorithm SHA256 | Out-File -FilePath C:\Myproject\df-mod2-forensic-copy1-1\evidence-hashes\hashes.txt

# Copy Evidence to Working Directory
Copy-Item -Path C:\Myproject\df-mod2-forensic-copy1-1\evidence -Destination C:\Myproject\df-mod2-forensic-copy1-1\evidence-copy -Recurse

# Calculate SHA256 Hashes for Forensic Copy
Get-FileHash -Path C:\Myproject\df-mod2-forensic-copy1-1\evidence-copy\* -Algorithm SHA256 | Out-File -FilePath C:\Myproject\df-mod2-forensic-copy1-1\evidence-copy-hashes\hashes.txt

Script.ps1
The Script.ps1 file was created to automate each evidence folder's hash calculation process. 

evidence-copy-hashes.ps1

To streamline the verification process, a new script was created to compile the hash results from both the original evidence and the forensic copy into a single combined file. This allows for a straightforward comparison of the hashes from the original evidence against those from the evidence copy.

