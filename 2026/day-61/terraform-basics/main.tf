terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraweek_bucket" {
  bucket = "terraweek-ajay-2026" # must be globally unique
  acl    = "private"
}

resource "aws_instance" "terraweek_ec2" {
  ami           = "ami-0ec10929233384c7f" # Ubuntu Linux in us-east-1
  instance_type = "t3.micro"

  tags = {
    # Name = "TerraWeek-Day1"
    Name = "TerraWeek-Modified"
  }
}
