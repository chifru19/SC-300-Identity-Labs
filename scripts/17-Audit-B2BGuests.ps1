<#
.SYNOPSIS
    Audits B2B Guest user accounts and their sign-in status in Entra ID.
.DESCRIPTION
    This script connects to Microsoft Graph to inspect external guest accounts,
    checking account enablement and recent sign-in activity.
#>

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Users)) {
    Write-Error "Microsoft.Graph.Users module is required."
    exit 1
}

Write-Host "Connecting to Microsoft Graph for B2B Guest audit..." -ForegroundColor Cyan
Connect-MgGraph -Scopes "User.Read.All", "AuditLog.Read.All"

try {
    Write-Host "Fetching guest users..." -ForegroundColor Cyan
    $guestUsers = Get-MgUser -Filter "userType eq 'Guest'" -Top 50 -Property Id, DisplayName, UserPrincipalName, AccountEnabled, SignInActivity
    
    $results = foreach ($user in $guestUsers) {
        [PSCustomObject]@{
            DisplayName       = $user.DisplayName
            UPN               = $user.UserPrincipalName
            AccountEnabled    = $user.AccountEnabled
            LastSignInDateTime = $user.SignInActivity.LastSignInDateTime
        }
    }
    
    if ($results) {
        $results | Format-Table -AutoSize
    } else {
        Write-Host "No guest users found in this tenant." -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Failed to retrieve guest user telemetry: $_"
    exit 1
}
