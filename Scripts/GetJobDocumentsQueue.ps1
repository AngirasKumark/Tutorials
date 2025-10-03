

param (
    [Parameter(Mandatory=$true)]
    [string]$RmsArrayJson,

    [Parameter(Mandatory=$true)]
    [string]$CidToken,

    [Parameter(Mandatory=$true)]
    [string]$JobId = "",

    [Parameter(Mandatory=$false)]
    [string]$OutputPath = ""
)


# Prepare the API request
$rmsArray = $RmsArrayJson | ConvertFrom-Json
$hostname = $rmsArray[1].ToLower()

$url = "https://$hostname/Relativity.REST/api/relativity-pdf/v1/queue/documents?jobId=$JobId"

Write-Host "Getting Documents job  queue from host: $hostname"
Write-Host "Calling $url"

try {
    $response = Invoke-RestMethod -Method Get `
        -Uri $url `
        -Headers @{
            "Content-Type" = "application/json"
            "X-CSRF-Header" = ""
            "Authorization" = "Bearer $CidToken"
        } `

    Write-Host "Job Queue API Response:"

    if ($response.JobDocumentsQueue) {
        $jobCount = $response.JobDocumentsQueue.Count
        $header = "`nJobs found: $jobCount`n"
        Write-Host $header
        $outputBuffer += $header
        $outputBuffer+ = $response.JobDocumentsQueue
    } else {
        $msg = "No jobs found in the response."   
        Write-Host $msg
        $outputBuffer += $msg
    }

    if ($OutputPath) {
        #$outputBuffer | Out-File -FilePath $OutputPath -Encoding utf8
        #New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath) | Out-Null
        $outputBuffer | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    }

} catch {
    Write-Host "Error calling Job Queue API:"
    Write-Host $_
    exit 1
} 
