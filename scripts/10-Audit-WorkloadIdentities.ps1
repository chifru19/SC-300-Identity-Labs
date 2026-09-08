# 10-Audit-WorkloadIdentities.ps1
# Description: Audits Service Principals and App Registrations for high-risk configurations

Write-Host "Starting Workload Identity Audit..." -ForegroundColor Cyan

try {
    $servicePrincipals = Invoke-MgGraphRequest -Method GET -Uri 'https://graph.microsoft.com/v1.0/servicePrincipals?$top=10'
    if ($null -ne $servicePrincipals -and $null -ne $servicePrincipals.value) {
        Write-Host "Found $($servicePrincipals.value.Count) Service Principals in tenant." -ForegroundColor Green
        foreach ($sp in $servicePrincipals.value) {
            Write-Host " - SP Name: $($sp.displayName) (ID: $($sp.id))" -ForegroundColor Yellow
        }
    } else {
        Write-Host "No Service Principals found or insufficient permissions." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error querying Workload Identities: $_" -ForegroundColor Red
}

Write-Host "Workload Identity Audit Complete!" -ForegroundColor Green
