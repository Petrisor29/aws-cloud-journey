# AWS Cloud Engineering Journey | 2026 Portfolio

## Project 1: Automated Static Web Infrastructure (S3)
*Implementation of a serverless web hosting solution with automated deployment using Python.*

### Technical Challenges & Troubleshooting (S3)

#### 1. Bash Shell History Expansion
* **Issue:** Received "Bash: event not found" when trying to echo HTML content containing "!".
* **Why it happened:** The exclamation mark is a special character in Bash used for command history.
* **Resolution:** Switched from double quotes to single quotes and used escaping techniques to ensure the 'index.html' was generated with the exact intended text.

#### 2. Public Access & S3 Security Layers
* **Issue:** Website URL returned a "403 Forbidden" error even after enabling static hosting.
* **Why it happened:** AWS S3 has multiple layers of protection. Disabling the "Block All Public Access" setting at the bucket level is a prerequisite, but it doesn't automatically grant read permissions.
* **Resolution:** Authored and applied a fine-grained JSON Bucket Policy to allow 's3:GetObject' for all principals. This taught me the importance of explicit permission granting in Cloud security.

#### 3. Boto3 Automation Script
* **Issue:** Files uploaded via the Python script were being downloaded by the browser instead of being displayed as a website.
* **Why it happened:** The script was uploading files with a default binary 'Content-Type', so the browser didn't recognize them as HTML.
* **Resolution:** Enhanced the 'update_site.py' script to explicitly set the 'ContentType' parameter to 'text/html' during the 'put_object' call.

### 🛠 Installation & Usage
1. **Clone the repo:**
   `git clone https://github.com/Petrisor29/aws-cloud-journey.git`
2. **Setup S3:**
   `python3 scripts/s3/update_site.py`
3. **Launch EC2:**
   `bash scripts/ec2/launch_instance.sh`
---

## Project 2: Managed Compute & Networking (EC2)
*Provisioning and configuring a Linux-based web server using Amazon Linux 2023.*

### Technical Challenges & Troubleshooting (EC2)

#### 1. Instance Type Eligibility
* **Issue:** "InvalidParameterCombination" error when launching a 't2.micro'.
* **Why it happened:** Availability of instance types in the Free Tier varies by region and account age.
* **Resolution:** Used CLI discovery commands to find eligible types and migrated to 't3.micro', which utilizes the superior AWS Nitro System.

#### 2. Network Connectivity (Private vs. Public IP)
* **Issue:** SSH connection failed with "Could not resolve hostname".
* **Why it happened:** Attempted to use the Private IP/Internal Hostname which is not routable over the public internet.
* **Resolution:** Identified the 'PublicIpAddress' via instance metadata queries and used it for the SSH connection.

#### 3. Security Group Orchestration
* **Issue:** Connection Timeout when accessing the server via browser.
* **Why it happened:** Security Groups are stateful firewalls that are closed by default. Port 80 (HTTP) was not authorized.
* **Resolution:** Implemented ingress rules via CLI. I also resolved a "missing argument" error by re-initializing the $SG_ID variable which had expired in the CloudShell session.

#### 4. Service Discovery & Management
* **Issue:** "Unit httpd.service not found" when checking server status.
* **Why it happened:** The Apache package installation was either skipped or failed during the initial setup phase.
* **Resolution:** Performed a manual recovery by installing 'httpd' via the DNF package manager and verified the service lifecycle using 'systemctl'.

---
**Skillset Demonstrated:** - Infrastructure Automation (Python/Boto3)
- Cloud Security (IAM & S3 Policies)
- Linux Systems Administration & Troubleshooting
- Virtual Private Cloud (VPC) Networking Fundamentals

### 🛠 Installation & Usage
1. **Clone the repo:**
   `git clone https://github.com/Petrisor29/aws-cloud-journey.git`
2. **Setup S3:**
   `python3 scripts/s3/update_site.py`
3. **Launch EC2:**
   `bash scripts/ec2/launch_instance.sh`

