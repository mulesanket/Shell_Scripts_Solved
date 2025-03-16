#!/bin/bash

######################################################################
#This script will list all the resources in the AWS account
#Author: Sanket Mule
#Version: v1.0
#Date: 2025-03-15
#
#Following are the resources that will be listed:
#1. EC2 Instances   
#2. S3 Buckets
#3. RDS Instances
#4. Lambda Functions
#5. Load Balancers
#6. Auto Scaling Groups
#
#Usage: ./aws_resources_list.sh <region> <service_name>
#Example: ./aws_resources_list.sh us-east-1 EC2
######################################################################

#Check if the required number of arguments are passed
if [ $# -eq 0 ]
then 
    echo "No arguments provided. Please provide region and service name"
    exit 1
elif [ $# -eq 1 ]
then
    echo "Only one argument provided. Please provide service name"
    exit 1
fi 

#Assign the region and service name to variables
region=$1
aws_service=$2

#Check if AWS CLI is installed
if command -v aws 
then 
    echo "AWS CLI is installed"
else
    echo "AWS CLI is not installed. Please install it and try again"
    exit 1
fi

#Check if AWS CLI is configured
if [ ! -d ~/.aws ]
then
    echo "AWS CLI is not configured. Please configure it and try again"
    exit 1
else
    echo "AWS CLI is configured"
fi

#Execute the AWS CLI command based on the service name
case $aws_service in
    EC2)
        aws ec2 describe-instances --region $region
        ;;
    S3)
        aws s3api list-buckets --region $region
        ;;
    RDS)
        aws rds describe-db-instances --region $region
        ;;
    Lambda)
        aws lambda list-functions --region $region
        ;;
    ELB)
        aws elb describe-load-balancers --region $region
        ;;
    ASG)
        aws autoscaling describe-auto-scaling-groups --region $region
        ;;
    *)
        echo "Invalid service name. Please provide a valid service name"
        ;;
esac