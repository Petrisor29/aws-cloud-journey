#!/bin/bash
# Script: deploy_web_server.sh
# Description: Automates EC2 provisioning & Web Server setup

# 1. Get the latest Amazon Linux 2023 AMI ID
AMI_ID=$(aws ec2 describe-images --owners amazon --filters "Name=name,Values=al2023-ami-2023*-x86_64" --query 'Images[0].ImageId' --output text)

echo "Using AMI: $AMI_ID"

# 2. Launch the EC2 instance (t3.micro is free-tier eligible in most regions)
# Note: We use the NEW secure key pair name we created earlier
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type t3.micro \
    --key-name petrisor-secure-key \
    --associate-public-ip-address \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MyFirstServer}]' \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "Instance launched with ID: $INSTANCE_ID"

# 3. Wait for the instance to be running
echo "Waiting for instance to be running..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

# 4. Get Public IP
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

echo "------------------------------------------------"
echo "Deployment Complete!"
echo "Server IP: $PUBLIC_IP"
echo "To connect: ssh -i petrisor-secure-key.pem ec2-user@$PUBLIC_IP"
echo "------------------------------------------------"
