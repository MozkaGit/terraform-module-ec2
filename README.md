# Terraform EC2 Infrastructure<br>[![Provision Dev infra](https://github.com/MozkaGit/terraform-module-ec2/actions/workflows/provision_dev.yaml/badge.svg)](https://github.com/MozkaGit/terraform-module-ec2/actions/workflows/provision_dev.yaml) [![Provision Prod infra](https://github.com/MozkaGit/terraform-module-ec2/actions/workflows/provision_prod.yaml/badge.svg)](https://github.com/MozkaGit/terraform-module-ec2/actions/workflows/provision_prod.yaml)

This project uses Terraform to deploy an infrastructure on AWS. The goal is to deploy this infrastructure as a module to two environments: Prod and Dev. Each environment has its own variables.

## Prerequisites

Before getting started, ensure that you have the following tools installed on your machine:

- An AWS account with access keys and permissions to deploy resources.
- Your own key pairs to allow provisioner remote-exec to install nginx in your EC2 instance.
- Terraform installed locally on your development machine.
- AWS CLI in order to configure credentials with `aws configure` command.

## Components

- **Provider AWS**: This block configures the AWS region and credentials file to be used.
  
- **Backend S3**: Used to store Terraform status in an S3 bucket.

- **EC2 Module**: Deploys an EC2 instance with a specific instance type and security group.

- **EIP module**: Associates an elastic IP address with the EC2 instance.

- **SG module**: Creates a security group.
## Modules

- main.tf: This file describes the resources to be deployed, including EC2 instances, security groups and elastic IP addresses.

- variables.tf: This file contains the variables used in the module, such as instance type and tags.

## Environnement Prod

### main.tf
Production environment configuration.

```hcl
provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["$HOME/.aws/credentials"]
}
... [other configurations]
```

### variables.tf
Variables specific to the production environment.

```hcl
variable "instancetype" {
  default = "t2.micro"
}
variable "aws_name_tag" {
  default = {
    Name = "ec2-prod-mozka"
  }
}
```

## Dev environment

### main.tf
Development environment configuration.

```hcl
provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["$HOME/.aws/credentials"]
}
... [other configurations]
```

### variables.tf
Variables specific to the development environment.

```hcl
variable "instancetype" {
  default = "t2.nano"
}
variable "aws_name_tag" {
  default = {
    Name = "ec2-dev-mozka"
  }
}
```

## Usage

To deploy the configuration, follow these steps:

1. Clone this repository to your local machine.
2. Navigato to the project directory.
3. Run the command `terraform init` to initialize Terraform and download the required providers.
4. Run the command `terraform apply` to create the ressources on AWS.
5. The deployment process may take a few moments. Once completed, you'll see the IP of your instance generated in `infos_ec2.txt` file.

To deploy the infrastructure, make sure you have configured your AWS credentials before running `terraform apply` for the desired environment (Prod or Dev).

## Cleanup

To avoid unnecessary charges, make sure to run `terraform destroy` in order to destroy the created resources after finishing your tests.
