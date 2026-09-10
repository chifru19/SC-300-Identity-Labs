<#
.SYNOPSIS
    Audits Microsoft Entra Conditional Access named locations.
.DESCRIPTION
    Script template to audit named locations, IP ranges, and country-based 
    blocking configurations for perimeter defense via Microsoft Graph.
.AUTHOR
    Frank Fru (https://frankfru.com)
#>

[CmdletBinding()]
param()

begin {
    Write-Host "[INFO] Initializing Module 22: Named Locations Audit..." -ForegroundColor Cyan
}

process {
    try {
        Write-Host "[INFO] Simulating Microsoft Graph connection for Conditional Access named locations..." -ForegroundColor Yellow
        
        $uri = "v1.0/identity/conditionalAccess/namedLocations"
        Write-Host "[INFO] Target Graph Endpoint: $uri" -ForegroundColor Gray
        
        $mockLocations = @(
            [PSCustomObject]@{ DisplayName = "Corporate HQ Trusted IPs"; Type = "ipRanges"; IsTrusted = $true },
            [PSCustomObject]@{ DisplayName = "Restricted Countries Block"; Type = "country"; IsTrusted = $false }
        )

        Write-Host "`n[+] Successfully processed $($mockLocations.Count) named location policies." -ForegroundColor Green
        foreach ($loc in $mockLocations) {
            Write-Host " - Location: $($loc.DisplayName) | Type: $($loc.Type) | Trusted: $($loc.IsTrusted)" -ForegroundColor White
        }
    }
    catch {
        Write-Error "An error occurred during the named locations audit: $_"
        exit 1
    }
}

end {
    Write-Host "[INFO] Module 22 execution completed successfully." -ForegroundColor Cyan
}