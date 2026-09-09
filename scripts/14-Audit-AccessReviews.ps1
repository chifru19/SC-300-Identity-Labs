<#
.SYNOPSIS
    Audits active Access Review definitions and review instances in Microsoft Entra ID.
.DESCRIPTION
    This script connects to Microsoft Graph using identity governance scopes
    to inspect access review schedules, definitions, and compliance status.
#>

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Identity.Governance)) {
    Write-Error "Microsoft.Graph.Identity.Governance module is required."
    exit 1
}

Write-Host "Connecting to Microsoft Graph for Access Review audit..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "AccessReview.Read.All"

try {
    Write-Host "Fetching access review definitions..." -ForegroundColor Cyan
    $reviews = Get-MgIdentityGovernanceAccessReviewDefinition -Top 20
    
    $results = foreach ($review in $reviews) {
        [PSCustomObject]@{
            DisplayName     = $review.DisplayName
            ReviewId        = $review.Id
            Status          = $review.Status
            CreatedDateTime = $review.CreatedDateTime
        }
    }
    
    if ($results) {
        $results | Format-Table -AutoSize
    } else {
        Write-Host "No active Access Review definitions found in this tenant." -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Failed to retrieve access review definitions: $_"
    exit 1
}
