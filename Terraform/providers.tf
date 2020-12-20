terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" //The source for where to pull terraform modules from
      version = "~> 2.0" //Pull all compatible modules above version 2.70 
    }
  }
}

provider "aws" {
  region                  = "us-east-1" //AWS destination region for terraform modules
  shared_credentials_file = "/home/ec2-user/.aws/credentials" //location of shared key file for Auth.
  profile = "ec2-user"//Profile used to provision and destroy resources.
}