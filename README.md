# terraform-monolith-ec2

This configuration deploys both the Flask backend and Express frontend on a single EC2 instance.

## Prerequisites

1. AWS account with appropriate permissions
2. AWS CLI configured with your credentials
3. Terraform installed on your local machine
4. An S3 bucket for storing Terraform state
5. An SSH key pair in your AWS account

## Configuration Files

- `main.tf`: Main Terraform configuration file
- `variables.tf`: Variable definitions
- `outputs.tf`: Output definitions
- `user_data.sh`: EC2 instance initialization script

## Infrastructure Components

- VPC with public subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 instance running both applications

## Deployment Instructions

1. Update the S3 backend configuration in `main.tf` with your bucket name
2. Update the `key_name` variable in `variables.tf` with your SSH key pair name
3. Initialize Terraform:
   ```bash
   terraform init
   ```
4. Review the deployment plan:
   ```bash
   terraform plan
   ```
5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Accessing the Applications

After deployment, Terraform will output:
- The EC2 instance's public IP
- Frontend URL (http://[public-ip]:3000)
- Backend URL (http://[public-ip]:5000)

## Clean Up

To destroy the infrastructure:
```bash
terraform destroy
``` 
