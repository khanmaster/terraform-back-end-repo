# main.tf

provider "aws" {

  region = "eu-west-1"
}
resource "aws_instance" "app_instance" {

  # which type of instance - ami to use
  ami = var.app_ami_id
  # "ami-095b735dce49535b5" ami-095b735dce49535b5

  # t2micro
  instance_type = "t2.micro"

  # associalte public ip with this instace
  associate_public_ip_address = true


  # name the ec2/resource
  tags = {
    Name = "shahrukh-terraform-remote-backend-testing"
  }
}