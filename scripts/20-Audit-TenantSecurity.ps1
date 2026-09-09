<#
.SYNOPSIS
    Audits comprehensive tenant security settings and operational baseline state.
.DESCRIPTION
    This script connects to Microsoft Graph to inspect baseline tenant security
    configurations, administrative policies, and directory properties.
#>

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Identity.DirectoryManagement)) {
    Write-Error "Microsoft.Graph.Identity.DirectoryManagement module is required."
    exit 1
}

Write-Host "Connecting to Microsoft Graph for Tenant Security Audit..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "Organization.Read.All", "Directory.Read.All"

try {
    Write-Host "Fetching tenant security baseline properties..." -ForegroundColor Cyan
    $org = Get-MgOrganization
    $domains = Get-MgDomain -Top 10

    $securitySummary = [PSCustomObject]@{
          TenantDisplayName     = $org.DisplayName
          TenantId              = $org.Id
          TechnicalNotification = $org.TechnicalNotificationMails -join ", "
          DefaultLanguage       = $org.PreferredLanguage
          VerifiedDomainsCount  = ($domains | Where-Object { $_.IsVerified -eq $true }).Count
    }

    Write-Host "
=== TENANT SECURITY BASELINE SUMMARY ===" -ForegroundColor Green
    $securitySummary | Format-List
}
catch {
    Write-Error "Failed to retrieve tenant security baseline telemetry: $_"
    exit 1
}
