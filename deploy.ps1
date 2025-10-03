# Sample data
$contacts = @(
    [PSCustomObject]@{ Id = 1; Name = "Alice"; Phone = "555-111" }
    [PSCustomObject]@{ Id = 2; Name = "Bob";   Phone = "555-222" }
)

# Export to CSV
$path = "output/contacts.csv"
New-Item -ItemType Directory -Force -Path (Split-Path $path) | Out-Null
$contacts | Export-Csv -Path $path -NoTypeInformation -Encoding UTF8
#$contacts | Out-File -FilePath $path -Encoding UTF8
Write-Host "CSV generated at $path"
