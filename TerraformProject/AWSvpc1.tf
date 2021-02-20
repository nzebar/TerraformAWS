//The VPC that is provisioned: VPC1
resource "aws_vpc" "VPC1" {
  cidr_block       = "192.168.0.0/16"// Address range for the Virtual Network.
  instance_tenancy = "default"// Keep this as default. Dedicated or host charges $2 per hr.
  enable_dns_support = true //Instead of using Route 53 for now.
  enable_dns_hostnames = true // AWS dns will also use hostnames of connected devices.

  tags = {
    Name = "VPC1"
  }
}

//The First Internet Gateway associated with VPC1
resource "aws_internet_gateway" "gw1_VPC1" {
  vpc_id = aws_vpc.VPC1.id
  
  tags = {
    Name = "VPC1_Internet_Gateway"
  }
}