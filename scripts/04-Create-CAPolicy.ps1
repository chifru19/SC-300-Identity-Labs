# 04-Create-CAPolicy.ps1
# Description: Creates a baseline Conditional Access policy enforcing MFA for all users via Graph API

$PolicyBody = @{
    displayName = "SC-300 Lab - Enforce MFA for All Users"
    state       = "enabledForReportingButNotEnforced"
    conditions  = @{
        applications = @{
            includeApplications = @("All")
        }
        users = @{
            includeUsers = @("All")
            excludeUsers = @()
        }
        clientAppTypes = @("all")
    }
    grantControls = @{
        operator               = "OR"
        authenticationStrength = @{
            id = "00000000-0000-0000-0000-000000000002"
        }
    }
} | ConvertTo-Json -Depth 10

# Create the policy via Graph SDK
New-MgIdentityConditionalAccessPolicy -BodyParameter $PolicyBody

Write-Host "Successfully created baseline Conditional Access Policy in report-only mode!" -ForegroundColor Green
