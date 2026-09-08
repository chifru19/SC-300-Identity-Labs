# 06-Create-AccessReview.ps1
# Description: Creates an automated access review definition to enforce least-privilege group hygiene

Import-Module Microsoft.Graph.Identity.Governance

$Group = Get-MgGroup -Filter "MailNickname eq 'sales-dept'"

if ($Group) {
    $Params = @{
        displayName               = "Sales Department Access Review"
        descriptionForAdmins      = "Quarterly review of membership for the Sales department security group."
        descriptionForReviewers   = "Please verify if members still require access."
        scope = @{
            "@odata.type"         = "#microsoft.graph.accessReviewQueryScope"
            query                 = "/groups//members"
            queryType             = "MicrosoftGraph"
        }
        settings = @{
            mailNotificationsEnabled     = $true
            reminderNotificationsEnabled = $true
            autoApplyDecisionsEnabled    = $false
            defaultDecision              = "None"
            instanceDurationInDays       = 7
            recurrence = @{
                pattern = @{
                    type     = "weekly"
                    interval = 1
                }
                range = @{
                    type            = "noEnd"
                    startDate       = (Get-Date).ToString("yyyy-MM-dd")
                }
            }
        }
    }

    New-MgIdentityGovernanceAccessReviewDefinition -BodyParameter $Params
    Write-Host "Successfully created Access Review definition for Sales Group!" -ForegroundColor Green
} else {
    Write-Warning "Sales security group not found. Ensure 'sales-dept' exists before running this script."
}
