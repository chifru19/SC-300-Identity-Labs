# 08-Audit-Lab.ps1
# Description: Comprehensive audit script to verify all deployed SC-300 lab components

Write-Host "Starting SC-300 Lab Environment Audit..." -ForegroundColor Cyan

# 1. Check Connection & Context
$Context = Get-MgContext
if ($Context) {
    Write-Host "[PASS] Connected to tenant: $($Context.Account)" -ForegroundColor Green
} else {
    Write-Warning "[FAIL] Not connected to Microsoft Graph. Run Connect-MgGraph first."
    exit
}

# 2. Check Administrative Units
Write-Host "
[Checking Administrative Units...]" -ForegroundColor Yellow
$AUs = Invoke-MgGraphRequest -Method GET -Uri 'https://graph.microsoft.com/v1.0/directory/administrativeUnits'
foreach ($au in $AUs.value) {
    Write-Host " - Found AU: $($au.displayName) (ID: $($au.id))" -ForegroundColor Green
}

# 3. Check Conditional Access Policies
Write-Host "
[Checking Conditional Access Policies...]" -ForegroundColor Yellow
$CAPolicies = Get-MgIdentityConditionalAccessPolicy -ErrorAction SilentlyContinue
if ($CAPolicies) {
    foreach ($policy in $CAPolicies) {
        Write-Host " - Policy: $($policy.DisplayName) [State: $($policy.State)]" -ForegroundColor Green
    }
} else {
    Write-Host " - No Conditional Access policies found or insufficient permissions." -ForegroundColor DarkYellow
}

# 4. Check Access Reviews
Write-Host "
[Checking Identity Governance Access Reviews...]" -ForegroundColor Yellow
$Reviews = Get-MgIdentityGovernanceAccessReviewDefinition -ErrorAction SilentlyContinue
if ($Reviews) {
    foreach ($review in $Reviews) {
        Write-Host " - Access Review: $($review.DisplayName)" -ForegroundColor Green
    }
} else {
    Write-Host " - No Access Reviews found or feature requires P2/Governance license." -ForegroundColor DarkYellow
}

Write-Host "
Lab Audit Complete!" -ForegroundColor Cyan
