# SC-300 Identity & Access Administrator Labs

Welcome to my hands-on portfolio repository documenting my 90-day technical project mastering Microsoft Entra ID, cloud security architecture, and identity governance. 

## 🌐 Project Overview
* **Tenant Environment:** Developer Sandbox (\chifru19googlemail.onmicrosoft.com\)
* **Core Tooling:** Microsoft Graph PowerShell SDK, REST API Wrappers (\Invoke-MgGraphRequest\), Git/GitHub CLI
* **Author:** Frank Fru ([frankfru.com](https://frankfru.com) | [GitHub Profile](https://github.com/chifru19))

---

## 📂 Lab Modules & Architecture

### Phase 1: Identity Lifecycle & Administrative Units
* **[01-Create-SalesAU.ps1](scripts/01-Create-SalesAU.ps1):** Provisions the departmental *Sales-AU* Administrative Unit via Microsoft Graph REST API to isolate management perimeters.
* **[02-Add-AUMember.ps1](scripts/02-Add-AUMember.ps1):** Automates user binding (Test User 1-3) to Administrative Units and security groups (\sales-dept\).
* **[03-Verify-LabState.ps1](scripts/03-Verify-LabState.ps1):** Performs rapid tenant health checks, scope validations, and object auditing.

### Phase 2: Security, Authentication, & Governance
* **[04-Create-CAPolicy.ps1](scripts/04-Create-CAPolicy.ps1):** Programmatically deploys baseline Conditional Access policies enforcing multi-factor authentication (MFA) via built-in authentication strengths in report-only mode.
* **[05-Configure-AuthMethods.ps1](scripts/05-Configure-AuthMethods.ps1):** Manages authentication methods policies and user registration enforcement campaigns for Microsoft Authenticator.
* **[06-Create-AccessReview.ps1](scripts/06-Create-AccessReview.ps1):** Automates least-privilege group hygiene through scheduled weekly identity governance access reviews.
* **[07-Configure-PIM.ps1](scripts/07-Configure-PIM.ps1):** Configures Privileged Identity Management (PIM) schedule settings for Just-In-Time (JIT) role elevation.

---
## 🚀 How to Run
1. Install the Microsoft Graph PowerShell SDK: \Install-Module Microsoft.Graph -Scope CurrentUser\
2. Connect to your tenant with required scopes: \Connect-MgGraph -Scopes "AdministrativeUnit.ReadWrite.All", "RoleManagement.ReadWrite.Directory"\
3. Execute desired scripts from the \scripts/\ directory.

* **[10-Audit-WorkloadIdentities.ps1](scripts/10-Audit-WorkloadIdentities.ps1):** Audits tenant Service Principals and App Registrations for high-risk configurations.
