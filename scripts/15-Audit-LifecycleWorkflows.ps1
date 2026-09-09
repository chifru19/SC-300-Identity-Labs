<#
.SYNOPSIS
    Audits Identity Governance Lifecycle Workflows in Microsoft Entra ID.
.DESCRIPTION
    This script connects to Microsoft Graph using lifecycle workflow scopes
    to inspect workflow definitions, enabled status, and execution states.
#>

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Identity.Governance)) {
    Write-Error "Microsoft.Graph.Identity.Governance module is required."
    exit 1
}

Write-Host "Connecting to Microsoft Graph for Lifecycle Workflows audit..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "IdentityWorkflow.Read.All"

try {
    Write-Host "Fetching lifecycle workflows..." -ForegroundColor Cyan
    $workflows = Get-MgIdentityGovernanceLifecycleWorkflow -Top 20
    
    $results = foreach ($workflow in $workflows) {
        [PSCustomObject]@{
            DisplayName = $workflow.DisplayName
            WorkflowId  = $workflow.Id
            IsEnabled   = $workflow.IsEnabled
            Category    = $workflow.Category
        }
    }
    
    if ($results) {
        $results | Format-Table -AutoSize
    } else {
        Write-Host "No lifecycle workflows found in this tenant." -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Failed to retrieve lifecycle workflows: $_"
    exit 1
}
