## Terraform remote back end with S3 and Dynamodb
![](\source\terraform-remote-state.jpeg)

- Provider block
```bash
# provider.tf
terraform {
  backend "s3" {
    bucket         = "shahrukhterraformremotebackend"
    dynamodb_table = "state-lock"
    key            = "shahrukh/terraform/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
```
```bash


# provider "aws" {

#   region = "eu-west-1"
# }
resource "aws_instance" "app_instance" {

  # which type of instance - ami to use
  ami = var.app_ami_id
   

  # t2micro
  instance_type = "t2.micro"

  # associalte public ip with this instace
  associate_public_ip_address = true


  # name the ec2/resource
  tags = {
    Name = "shahrukh-terraform-remote-backend-testing"
  }
}

```
- Remote state
- create s3 bucket - enable versioning - server side encryption AES256
```bash

# create a service on the cloud - launch an ec2 instance on aws
# HCL syntax key = value

# which part of AWS - which region
# provider "aws" {

#   region = "eu-west-1"
# }

 
resource "aws_s3_bucket" "shahrukh-terra-remote-backend" {
  bucket = "shahrukhterraformremotebackend"
  versioning {
    enabled = true
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_algorithm
      }
    }
  }
}
# create dynamodb
resource "aws_dynamodb_table" "statelock" {
  name         = "state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key

  attribute {
    name = var.LockID
    type = "S"
  }

}





```