# Enterprise-Grade AWS Migration and Auto Scaling Infrastructure

## Overview

This project demonstrates the migration of a WordPress application from an on-premises environment to AWS and the implementation of a resilient, scalable AWS architecture using Terraform.

## AWS Architecture

- Amazon VPC
- Public and private subnets
- Application Load Balancer
- EC2 Auto Scaling Group
- Amazon RDS MySQL
- NAT Gateway
- IAM
- AWS Systems Manager Session Manager
- CloudWatch
- Amazon S3
- Terraform

## WordPress Migration

The WordPress application was migrated from an on-premises environment to AWS.

The migration included:
1. AWS infrastructure provisioning with Terraform
2. WordPress deployment on EC2
3. MySQL database migration to Amazon RDS
4. Application configuration and database connectivity
5. Application Load Balancer integration
6. Auto Scaling configuration
7. Application validation through the ALB DNS endpoint

## Auto Scaling

The Auto Scaling Group is configured with:

- Minimum capacity: 1
- Desired capacity: 1
- Maximum capacity: 6
- CPU target: 50%
- EC2 health checks
- Automatic replacement of unhealthy instances

Testing confirmed that EC2 instances registered with the ALB and reported healthy.

## Security

- EC2 instances use private subnets
- RDS uses private networking
- IAM roles are used instead of embedded credentials
- AWS Systems Manager Session Manager is used instead of SSH
- Terraform state is stored remotely in Amazon S3
- Sensitive migration data is excluded through .gitignore

## Infrastructure as Code

Terraform configuration is organized into:

- backend-bootstrap
- wordpress-migration
- autoscaling

## Validation

The deployed environment was validated using AWS CLI and the AWS Management Console.

Validation confirmed:

- EC2 instances running
- Auto Scaling instances in InService state
- Auto Scaling instances reporting Healthy
- ALB targets reporting healthy
- WordPress accessible through the ALB DNS endpoint
- Auto Scaling successfully returning to the desired capacity

## Technologies

AWS | Terraform | EC2 | RDS | ALB | Auto Scaling | VPC | IAM | SSM | CloudWatch | S3 | MySQL | WordPress

## Author

Oluyemi Abiona

Cloud / DevOps Engineer | AWS | Terraform | Kubernetes | Infrastructure Automation
