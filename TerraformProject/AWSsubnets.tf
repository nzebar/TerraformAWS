//Subnet1 located in Route Table 2, VPC1.
resource "aws_subnet" "subnet1_VPC1" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet1_VPC1"
  }
}
  
  
//Subnet2 located in Route_Table_2, VPC1
resource "aws_subnet" "subnet2_VPC1" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet2_VPC1"
  }
}
  
    # resource "aws_vpc_endpoint_subnet_association" "codedeploy_endpoint_private_subnet_1_association_1" {
    #   vpc_endpoint_id = aws_vpc_endpoint.codedeploy_endpoint.id
    #   subnet_id       = aws_subnet.subnet2_VPC1.id
    # } 
    
    # resource "aws_vpc_endpoint_subnet_association" "codedeploy_endpoint_private_subnet_1_association_2" {
    #   vpc_endpoint_id = aws_vpc_endpoint.codedeploy_endpoint_commands_secure.id
    #   subnet_id       = aws_subnet.subnet2_VPC1.id
    # } 
    
//Subnet3 located in Route_Table_2, VPC1
resource "aws_subnet" "subnet3_VPC1" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet3_VPC1"
  }
}
    
    
resource "aws_subnet" "subnet4_VPC1" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet4_VPC1"
  }
}

resource "aws_subnet" "subnet5_VPC1" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "192.168.5.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet5_VPC1"
  }
}

    # resource "aws_vpc_endpoint_subnet_association" "codedeploy_endpoint_private_subnet_5_association_1" {
    #   vpc_endpoint_id = aws_vpc_endpoint.codedeploy_endpoint.id
    #   subnet_id       = aws_subnet.subnet2_VPC1.id
    # } 
    
    # resource "aws_vpc_endpoint_subnet_association" "codedeploy_endpoint_private_subnet_5_association_2" {
    #   vpc_endpoint_id = aws_vpc_endpoint.codedeploy_endpoint_commands_secure.id
    #   subnet_id       = aws_subnet.subnet2_VPC1.id
    # } 

resource "aws_subnet" "subnet6_VPC1" {
  vpc_id     = aws_vpc.VPC1.id
  cidr_block = "192.168.6.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet6_VPC1"
  }
}