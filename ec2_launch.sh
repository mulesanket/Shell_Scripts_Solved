#!/bin/bash

######################################################################
#This script will launch ec2 instance using Cron Job
#Author: Sanket Mule
#Version: v1.0
#Date: 2025-03-16
######################################################################

#Check if AWS CLI is installed
if ! command -v aws > /dev/null 2>&1
then 
    echo "AWS CLI is not installed. Please install it and try again"
    exit 1
else
    echo "AWS CLI is installed"
fi

#Check if AWS CLI is configured
if [ ! -d ~/.aws ]
then
    echo "AWS CLI is not configured. Please configure it and try again"
    exit 1
else
    echo "AWS CLI is configured"
fi

#Assign the region and instance type to variables
region=ap-south-1
instance_type=t2.micro

#Launch EC2 instance
aws ec2 run-instances \
    --image-id ami-00bb6a80f01f03502 \
    --count 2 \
    --instance-type $instance_type \
    --key-name MyLinuxServer-Key \
    --security-group-ids sg-0a2cfb2473a9f5f79 \
    --region $region

#Check if the instance is launched successfully
if [ $? -eq 0 ]
then
    echo "EC2 instance launched successfully"
else
    echo "Failed to launch EC2 instance"
    exit 1
fi