# SC-300 Identity and Access Management (IAM) Labs

Welcome to my **Microsoft Identity and Access Management (SC-300)** automation repository! This project documents my hands-on journey implementing cloud identity governance, security baselines, and automated DevSecOps workflows using PowerShell and the Microsoft Graph SDK.

---

## 👤 Author & Professional Profiles

* **Author:** Frank Fru
* **Website:** [frankfru.com](https://frankfru.com)
* **GitHub:** [@chifru19](https://github.com/chifru19)
* **LinkedIn:** [Connect with Frank Fru on LinkedIn](https://www.linkedin.com/in/frank-fru)

---

## 📂 Repository Structure & Lab Modules

### Phase 1: Identity Management, Lifecycles & Governance (Days 1–30)
| Module | Script Name | Description |
| :--- | :--- | :--- |
| **01** | `01-Create-SalesAU.ps1` | Programmatically provisions Administrative Units for organizational separation. |
| **02** | `02-Add-AUMember.ps1` | Assigns users to specific Administrative Units via Microsoft Graph. |
| **03** | `03-Verify-LabState.ps1` | Validates active tenant configurations and group assignments. |
| **04** | `04-Create-CAPolicy.ps1` | Deploys baseline Conditional Access governance structures. |
| **05** | `05-Configure-AuthMethods.ps1` | Configures administrative authentication methods and security defaults. |
| **06** | `06-Create-AccessReview.ps1` | Automates identity governance access reviews to prevent privilege creep. |
| **07** | `07-Configure-PIM.ps1` | Implements Privileged Identity Management (PIM) for Just-In-Time role activation. |
| **08** | `08-Audit-Lab.ps1` | Comprehensive environment and role auditing script. |
| **09** | `09-Clean-DuplicateAUs.ps1` | Cleanup automation script to resolve duplicate object states. |

### Phase 2: Conditional Access, Risk & Workloads (Days 31–60)
| Module | Script Name | Description |
| :--- | :--- | :--- |
| **10** | `10-Audit-WorkloadIdentities.ps1` | Scans and audits non-human identities (service principals & app registrations). |
| **11** | `11-Audit-AppRegistrations.ps1` | Audits application credentials, secrets, and certificates for risk compliance. |
| **12** | `12-Audit-RiskDetections.ps1` | Queries Entra ID Protection risk signals and risky user telemetry. |

### Phase 3: Privileged Identity Management & Governance (Days 61–90)
| Module | Script Name | Description |
| :--- | :--- | :--- |
| **13** | `13-Audit-PIMAssignments.ps1` | Audits PIM eligible and active privileged role assignments and schedule instances. |
| **14** | `14-Audit-AccessReviews.ps1` | Inspects active Access Review definitions and review instances to enforce governance compliance. |

### Phase 4: Identity Governance Lifecycles & B2B Collaboration (Days 91–105)
| Module | Script Name | Description |
| :--- | :--- | :--- |
| **15** | `15-Audit-LifecycleWorkflows.ps1` | Audits Identity Governance Lifecycle Workflows and execution states. |

### Phase 5: Entitlement Management & External ID Governance (Days 106–120)
| Module | Script Name | Description |
| :--- | :--- | :--- |
| **16** | `16-Audit-AccessPackages.ps1` | Inspects entitlement management access packages, catalogs, and policies. |
| **17** | `17-Audit-B2BGuests.ps1` | Audits B2B guest user accounts, enablement status, and recent sign-in telemetry. |

### Phase 6: Hybrid Identity & Tenant Security Baseline (Days 121+)
| Module | Script Name | Description |
| :--- | :--- | :--- |
| **18** | `18-Audit-HybridSync.ps1` | Audits hybrid identity directory synchronization status and last sync health. |
| **19** | `19-Audit-EnterpriseApps.ps1` | Scans enterprise applications and service principal configurations. |
| **20** | `20-Audit-TenantSecurity.ps1` | Evaluates overarching tenant security baseline settings and administrative notifications. |

---

## 🛡️ Automated CI/CD Pipeline (`validate-scripts.yml`)

Every script pushed to this repository is automatically linted using **PSScriptAnalyzer** via GitHub Actions to ensure high code quality, syntax correctness, and production readiness.
