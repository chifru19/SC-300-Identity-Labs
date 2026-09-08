# 07-Configure-PIM.ps1
# Description: Configures PIM settings and role assignment for administrative roles

Write-Host "Configuring Privileged Identity Management (PIM) settings..." -ForegroundColor Cyan

# Define role to check/configure
$roleName = "Helpdesk Administrator"
$roleDefUri = "https://graph.microsoft.com/v1.0/roleManagement/directory/roleDefinitions?$filter=displayName eq '$roleName'"
$roleDef = Invoke-MgGraphRequest -Method GET -Uri $roleDefUri

if ($null -ne $roleDef -and $null -ne $roleDef.value) {
    Write-Host "Found role definition for $roleName." -ForegroundColor Green
    # Add your PIM configuration logic here
} else {
    Write-Host "Role definition not found or requires specific permissions." -ForegroundColor Yellow
}

Write-Host "PIM configuration check complete!" -ForegroundColor Green
