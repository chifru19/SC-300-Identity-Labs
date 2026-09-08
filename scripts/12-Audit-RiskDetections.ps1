<#
.SYNOPSIS
    Audits risky users and identity protection signals in Microsoft Entra ID.
.DESCRIPTION
    This script connects to Microsoft Graph using least-privilege identity protection
    scopes and queries risky user objects to evaluate security posture.
#>

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Identity.SignIns)) {
    Write-Error "Microsoft.Graph.Identity.SignIns module is required."
    exit 1
}

Write-Host "Connecting to Microsoft Graph for Identity Protection audit..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "IdentityRiskyUser.Read.All"

try {
    Write-Host "Fetching risky user reports..." -ForegroundColor Cyan
    $riskyUsers = Get-MgRiskyUser -Top 20 -Property Id, UserDisplayName, RiskLevel, RiskState, RiskDetail, RiskLastUpdatedDateTime
    
    $results = foreach ($user in $riskyUsers) {
        [PSCustomObject]@{
            DisplayName   = $user.UserDisplayName
            UserId        = $user.Id
            RiskLevel     = $user.RiskLevel
            RiskState     = $user.RiskState
            RiskDetail    = $user.RiskDetail
            LastUpdated   = $user.RiskLastUpdatedDateTime
        }
    }
    
    if ($results) {
        $results | Format-Table -AutoSize
    } else {
        Write-Host "No risky users detected in the tenant. Environment is secure!" -ForegroundColor Green
    }
}
catch {
    Write-Error "Failed to retrieve risk detection logs: $_"
    exit 1
}
