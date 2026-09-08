# 03-Verify-LabState.ps1
# Description: Quick health check for tenant connection, AUs, and users

Get-MgContext
$AU = Invoke-MgGraphRequest -Method GET -Uri 'https://graph.microsoft.com/v1.0/directory/administrativeUnits'
$AU.value | Select-Object Id, DisplayName, Description
Get-MgUser -All | Select-Object DisplayName, UserPrincipalName, Department, Id
