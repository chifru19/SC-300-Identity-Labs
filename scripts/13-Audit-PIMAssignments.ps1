<#
.SYNOPSIS
    Audits PIM eligible and active role assignments in Microsoft Entra ID.
.DESCRIPTION
    This script connects to Microsoft Graph using identity governance scopes
    to review privileged role schedule instances and elevation status.
#>

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Identity.Governance)) {
    Write-Error "Microsoft.Graph.Identity.Governance module is required."
    exit 1
}

Write-Host "Connecting to Microsoft Graph for PIM audit..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "RoleManagement.Read.Directory"

try {
    Write-Host "Fetching privileged role assignment schedules..." -ForegroundColor Cyan
    $assignments = Get-MgRoleManagementDirectoryRoleAssignmentScheduleInstance -Top 20
    
    $results = foreach ($assignment in $assignments) {
        [PSCustomObject]@{
            RoleDefinitionId = $assignment.RoleDefinitionId
            PrincipalId      = $assignment.PrincipalId
            AssignmentType   = $assignment.AssignmentType
            Status           = $assignment.Status
        }
    }
    
    if ($results) {
        $results | Format-Table -AutoSize
    } else {
        Write-Host "No active PIM schedule instances found in this tenant." -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Failed to retrieve PIM assignments: $_"
    exit 1
}
