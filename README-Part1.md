# Terraform AWS Infrastructure

## Overview

This project provisions AWS infrastructure using Terraform, including:

* VPC with public and private subnets
* EC2 instances for application hosting
* RDS PostgreSQL database
* Security groups
* Simple Python Flask Hello World application

## Prerequisites

* AWS Account
* AWS CLI
* Terraform
* IAM credentials with required AWS permissions
* EC2 key pair for SSH access

## AWS Configuration

Configure AWS CLI:

```bash
aws configure
```

## Terraform Configuration

Configurable parameters are maintained in `variables.tf`.

Update `terraform.tfvars` with the required values:

```hcl
aws_region         = "ap-south-1"
project_name       = "devops-assignment"
instance_type      = "t3.micro"
key_name           = "devops-assignment-key"
db_name            = "appdb"
db_username        = "dbadmin"
db_password        = "my_password"
db_instance_class  = "db.t3.micro"
```

## Deployment

Initialize Terraform:

```bash
terraform init
```

Format and validate:

```bash
terraform fmt
terraform validate
```

Review the infrastructure:

```bash
terraform plan
```

Create the infrastructure:

```bash
terraform apply
```

Enter `yes` when prompted.

## Security

* EC2 instances are deployed in public subnets.
* RDS PostgreSQL is deployed in private subnets.
* RDS is not publicly accessible.
* PostgreSQL port `5432` allows traffic only from the EC2 security group.
* SSH access is provided through the EC2 key pair.

## Destroy Infrastructure

After completing the assignment:

```bash
terraform destroy
```

This removes the AWS resources created by Terraform.

## Challenges Faced

### 1. RDS Identifier Error

The RDS identifier was invalid because it started with a number.

**Resolution:** Changed `project_name` so that the RDS identifier starts with a letter.

### 2. RDS Password Error

The RDS master password contained unsupported special characters such as `/`, `@`, `"`, or spaces.

**Resolution:** Replaced them with allowed printable ASCII characters.
