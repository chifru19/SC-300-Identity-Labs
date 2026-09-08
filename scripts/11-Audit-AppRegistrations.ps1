<#
.SYNOPSIS
    Audits existing App Registrations and Service Principals in the tenant.
.DESCRIPTION
    This script connects to Microsoft Graph and retrieves application objects
    to review non-human identities and credentials.
#>

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Applications)) {
    Write-Error "Microsoft.Graph.Applications module is required."
    exit 1
}

Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "Application.Read.All"

try {
    Write-Host "Fetching registered applications..." -ForegroundColor Cyan
    $apps = Get-MgApplication -Top 10 -Property Id, DisplayName, CreatedDateTime, KeyCredentials, PasswordCredentials
    
    foreach ($app in $apps) {
        [PSCustomObject]@{
            AppName         = $app.DisplayName
            AppId           = $app.Id
            Created         = $app.CreatedDateTime
            HasSecrets      = ($app.PasswordCredentials.Count -gt 0)
            HasCertificates = ($app.KeyCredentials.Count -gt 0)
        }
    } | Format-Table -AutoSize
}
catch {
    Write-Error "Failed to retrieve applications: $_"
    exit 1
}
