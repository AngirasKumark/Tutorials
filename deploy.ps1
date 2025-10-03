# Sample data
$contacts = @(
    [PSCustomObject]@{ Id = 1; Name = "Alice"; Phone = "555-111" }
    [PSCustomObject]@{ Id = 2; Name = "Bob";   Phone = "555-222" }
)

# Export to CSV
 $header = "`nJobs found: $contacts.Count`n"
 Write-Host $header
 $outputBuffer += $header
 $outputBuffer += $contacts
$path = "output/contacts.csv"
New-Item -ItemType Directory -Force -Path (Split-Path $path) | Out-Null
$outputBuffer | Export-Csv -Path $path -NoTypeInformation -Encoding UTF8
#$contacts | Out-File -FilePath $path -Encoding UTF8
Write-Host "CSV generated at $path"
