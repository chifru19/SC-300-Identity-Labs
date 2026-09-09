<#
.SYNOPSIS
    Audits Entra ID Entitlement Management access packages and catalogs.
.DESCRIPTION
    This script connects to Microsoft Graph using entitlement management scopes
    to inspect access packages, associated catalogs, and lifecycle configurations.
#>

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Identity.Governance)) {
    Write-Error "Microsoft.Graph.Identity.Governance module is required."
    exit 1
}

Write-Host "Connecting to Microsoft Graph for Entitlement Management audit..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "EntitlementManagement.Read.All"

try {
    Write-Host "Fetching access packages..." -ForegroundColor Cyan
    $accessPackages = Get-MgEntitlementManagementAccessPackage -Top 20 -ExpandProperty "catalog"
    
    $results = foreach ($pkg in $accessPackages) {
        [PSCustomObject]@{
            DisplayName   = $pkg.DisplayName
            AccessPackageId = $pkg.Id
            Description   = $pkg.Description
            CatalogName   = $pkg.Catalog.DisplayName
            IsHidden      = $pkg.IsHidden
        }
    }
    
    if ($results) {
        $results | Format-Table -AutoSize
    } else {
        Write-Host "No access packages found in this tenant." -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Failed to retrieve access packages: $_"
    exit 1
}
