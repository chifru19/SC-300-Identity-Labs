<#
.SYNOPSIS
    Audits Hybrid Identity and Directory Synchronization status in Entra ID.
.DESCRIPTION
    This script connects to Microsoft Graph to inspect tenant synchronization
    settings, directory sync enabled status, and last sync timestamp.
#>

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Identity.DirectoryManagement)) {
    Write-Error "Microsoft.Graph.Identity.DirectoryManagement module is required."
    exit 1
}

Write-Host "Connecting to Microsoft Graph for Hybrid Sync audit..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "Organization.Read.All"

try {
    Write-Host "Fetching organization directory synchronization details..." -ForegroundColor Cyan
    $org = Get-MgOrganization
    $syncEnabled = $org.OnPremisesSyncEnabled
    $lastSyncTime = $org.OnPremisesLastSyncDateTime
    $syncAgentName = $org.OnPremisesProvisioning[0].ServiceProviderDisplayName

    $result = [PSCustomObject]@{
        TenantId              = $org.Id
        DisplayName           = $org.DisplayName
        OnPremisesSyncEnabled = $syncEnabled
        LastSyncDateTime      = $lastSyncTime
        ServiceProvider       = $syncAgentName
    }

    $result | Format-List
}
catch {
    Write-Error "Failed to retrieve hybrid synchronization telemetry: $_"
    exit 1
}
