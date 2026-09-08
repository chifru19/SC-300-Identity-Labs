# 05-Configure-AuthMethods.ps1
# Description: Configures authentication methods policy settings for Microsoft Authenticator

Import-Module Microsoft.Graph.Identity.Signins

$Params = @{
    registrationEnforcement = @{
        authenticationMethodsRegistrationCampaign = @{
            state = "enabled"
            snoozeDurationInDays = 1
        }
    }
}

Update-MgBetaPolicyAuthenticationMethodPolicy -BodyParameter $Params
Write-Host "Successfully updated Authentication Methods Policy settings!" -ForegroundColor Green
