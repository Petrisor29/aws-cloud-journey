# AWS Cloud Engineering Journey | 2026 Portfolio

## 🛡️ Security Audit & Post-Mortem (Phase 2)
> **Incident:** Accidental exposure of private RSA keys (.pem) in Git history.
> **Response:** Immediate revocation of AWS Key Pairs, termination of compromised EC2 instances, and a complete Git history purge (Force Push).
> **Lesson Learned:** "Security-First" approach implemented—.gitignore initialized before any resource provisioning.

---

## Project 1: Automated Static Web Hosting (S3)
*Status: Completed & Secured*

## Project 2: Managed Compute & Networking (EC2)
*Status: In Progress (Refactoring for Security)*
