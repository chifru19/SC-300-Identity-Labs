# 02-Add-AUMember.ps1
# Description: Adds Test User 1 to the Sales-AU Administrative Unit via native SDK

$AU = Invoke-MgGraphRequest -Method GET -Uri 'https://graph.microsoft.com/v1.0/directory/administrativeUnits?$filter=displayName eq ''Sales-AU'''
$AUId = $AU.value[0].id
$User = Get-MgUser -Filter "UserPrincipalName eq 'testuser1@chifru19googlemail.onmicrosoft.com'"

$Params = @{
    "@odata.id" = "https://graph.microsoft.com/v1.0/users/"
}
New-MgDirectoryAdministrativeUnitMemberByRef -AdministrativeUnitId $AUId -BodyParameter $Params

Write-Host "Successfully added Test User 1 to the Sales-AU Administrative Unit!" -ForegroundColor Green
