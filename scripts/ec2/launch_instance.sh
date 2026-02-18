#!/bin/bash
# Script to launch a T3.Micro instance with Amazon Linux 2023

AMI_ID=$(aws ec2 describe-images --owners amazon --filters "Name=name,Values=al2023-ami-2023*-x86_64" --query 'Images[0].ImageId' --output text)

echo "Launching instance with AMI: $AMI_ID"

aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type t3.micro \
    --key-name my-aws-key \
    --associate-public-ip-address \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MyFirstServer}]'
