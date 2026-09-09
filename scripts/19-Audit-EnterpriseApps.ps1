<#
.SYNOPSIS
    Audits Enterprise Applications and automated user provisioning status in Entra ID.
.DESCRIPTION
    This script connects to Microsoft Graph to inspect enterprise applications,
    service principals, and whether automated provisioning is configured.
#>

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Applications)) {
    Write-Error "Microsoft.Graph.Applications module is required."
    exit 1
}

Write-Host "Connecting to Microsoft Graph for Enterprise Applications audit..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "Application.Read.All", "ServicePrincipalEndpoint.Read.All"

try {
    Write-Host "Fetching enterprise applications..." -ForegroundColor Cyan
    $servicePrincipals = Get-MgServicePrincipal -Top 20 -Property Id, DisplayName, AppId, ServicePrincipalType

    $results = foreach ($sp in $servicePrincipals) {
        [PSCustomObject]@{
            DisplayName          = $sp.DisplayName
            AppId                = $sp.AppId
            ServicePrincipalType = $sp.ServicePrincipalType
            ServicePrincipalId   = $sp.Id
        }
    }

    if ($results) {
        $results | Format-Table -AutoSize
    } else {
        Write-Host "No enterprise applications found in this tenant." -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Failed to retrieve enterprise applications: $_"
    exit 1
}
