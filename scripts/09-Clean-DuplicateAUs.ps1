# 09-Clean-DuplicateAUs.ps1
# Description: Cleans up duplicate Sales-AU Administrative Units, keeping only the most recent one

$AUs = Invoke-MgGraphRequest -Method GET -Uri 'https://graph.microsoft.com/v1.0/directory/administrativeUnits'
$SalesAUs = $AUs.value | Where-Object { $_.displayName -eq "Sales-AU" }

if ($SalesAUs.Count -gt 1) {
    Write-Host "Found $($SalesAUs.Count) Sales-AU instances. Cleaning duplicates..." -ForegroundColor Yellow
    for ($i = 1; $i -lt $SalesAUs.Count; $i++) {
        $id = $SalesAUs[$i].id
        Write-Host "Deleting duplicate AU ID: $id" -ForegroundColor Red
        Invoke-MgGraphRequest -Method DELETE -Uri "https://graph.microsoft.com/v1.0/directory/administrativeUnits/$id"
    }
    Write-Host "Cleanup complete!" -ForegroundColor Green
} else {
    Write-Host "No duplicate Sales-AU instances found." -ForegroundColor Green
}
