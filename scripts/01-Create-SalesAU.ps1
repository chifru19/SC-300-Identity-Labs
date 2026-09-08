# 01-Create-SalesAU.ps1
# Description: Provisions the Sales Administrative Unit using Microsoft Graph REST API

$AuParams = @{
    displayName = "Sales-AU"
    description = "Administrative Unit for Sales Department management delegation"
}

$Body = $AuParams | ConvertTo-Json
$Response = Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/directory/administrativeUnits" -Body $Body

Write-Host "Successfully created Sales Administrative Unit!" -ForegroundColor Green
$Response | Format-List Id, DisplayName, Description
