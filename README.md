# AWS 3-Tier Web Architecture Deployment ☁️

## Overview
This project demonstrates the deployment of a secure, highly available 3-tier web architecture on Amazon Web Services (AWS). It features a dynamic PHP web frontend hosted on an EC2 instance that communicates with a private RDS MySQL database, showcasing core cloud engineering and security principles.

## Architecture & Services Used
* **Compute (Amazon EC2):** Deployed an Amazon Linux 2023 instance acting as a Bastion Host and Web Server (Apache + PHP-FPM).
* **Database (Amazon RDS):** Provisioned a managed MySQL database instance.
* **Networking (Amazon VPC):** Utilized public and private subnets, routing tables, and an Internet Gateway to manage traffic flow.
* **Security (Security Groups & IAM):** * Implemented strict SG-to-SG referencing (the database only accepts traffic from the EC2 security group on port 3306).
  * Created custom IAM User Groups with specific Read-Only JSON policies to enforce the Principle of Least Privilege.
* **Cost Management (AWS Budgets):** Configured a Zero-Spend Budget with automated email alerts to proactively monitor infrastructure costs.

## Security Best Practices Implemented
1. **Database Isolation:** The RDS instance was deployed without a public IP address, making it invisible to the internet.
2. **Secret Management:** Refactored the application code to eliminate hardcoded database credentials. Passwords and endpoints are securely passed to the application using OS-level Environment Variables via PHP-FPM configuration (`/etc/php-fpm.d/www.conf`).
3. **Troubleshooting & Diagnostics:** Handled HTTP 500 errors by analyzing server logs and implementing strict error reporting (`mysqli_report`) for rapid debugging.

## How It Works
1. Users access the public IP of the EC2 instance via a web browser (Port 80).
2. The Apache web server hands the request to PHP-FPM.
3. PHP retrieves the secure database credentials from the system's environment variables.
4. The application queries the RDS MySQL database (Port 3306) and dynamically renders the employee data table into the HTML response.

## Future Enhancements
* Migrate environment variables to **AWS Secrets Manager** for automated secret rotation.
* Place the EC2 instance behind an **Application Load Balancer (ALB)** and an **Auto Scaling Group**.
