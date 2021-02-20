resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.VPC1.main_route_table_id

  tags = {
    Name = "VPC1 Default Table"
  }
}



resource "aws_route_table" "public_route_table_useast1a" {
  vpc_id = aws_vpc.VPC1.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1_VPC1.id
  }

  tags = {
    Name = "Public-USeast1a"
  }
}

    resource "aws_route_table_association" "subnet_1_pub_route_useast1a_association" {
    subnet_id      = aws_subnet.subnet1_VPC1.id
    route_table_id = aws_route_table.public_route_table_useast1a.id
    }
    
resource "aws_route_table" "private_route_table_1_useast1a" {
  vpc_id = aws_vpc.VPC1.id
  
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.nat_useast1a.id
  }
  
  tags = {
    Name = "Private1-USeast1a"
  }
}

    resource "aws_route_table_association" "subnet_2_priv_route_useast1a_association" {
    subnet_id      = aws_subnet.subnet2_VPC1.id
    route_table_id = aws_route_table.private_route_table_1_useast1a.id
    }
    
resource "aws_route_table" "private_route_table_2_useast1a" {
  vpc_id = aws_vpc.VPC1.id

  tags = {
    Name = "Private2-USeast1a"
  }
}
    
    resource "aws_route_table_association" "subnet_3_priv_route_useast1a_association" {
    subnet_id      = aws_subnet.subnet3_VPC1.id
    route_table_id = aws_route_table.private_route_table_2_useast1a.id
    }


resource "aws_route_table" "public_route_table_useast1b" {
  vpc_id = aws_vpc.VPC1.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1_VPC1.id
  }
  
  tags = {
    Name = "Public-USeast1b"
  }
}

    resource "aws_route_table_association" "subnet_4_pub_route_useast1b_association" {
    subnet_id      = aws_subnet.subnet4_VPC1.id
    route_table_id = aws_route_table.public_route_table_useast1b.id
    }
    
resource "aws_route_table" "private_route_table_1_useast1b" {
  vpc_id = aws_vpc.VPC1.id
  
   route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.nat_useast1b.id
  }
  
  
  tags = {
    Name = "Private1-USeast1b"
  }
}

    resource "aws_route_table_association" "subnet_5_priv_route_table_1_useast1b_association" {
    subnet_id      = aws_subnet.subnet5_VPC1.id
    route_table_id = aws_route_table.private_route_table_1_useast1b.id
    }
    
resource "aws_route_table" "private_route_table_2_useast1b" {
  vpc_id = aws_vpc.VPC1.id

  tags = {
    Name = "Private-USeast1b"
  }
}
    
    resource "aws_route_table_association" "subnet_6_priv_route_2_useast1b_association" {
    subnet_id      = aws_subnet.subnet6_VPC1.id
    route_table_id = aws_route_table.private_route_table_2_useast1b.id
    }