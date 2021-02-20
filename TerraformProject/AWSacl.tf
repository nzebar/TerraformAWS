resource "aws_default_network_acl" "default_network_acl_VPC1" {
  default_network_acl_id = aws_network_acl.dummy_default_acl_VPC1.id
  
  #Nothing is displayed to Deny Access to subnets not assigned to a 
  #NACL, where the setting is optional.
  
  ingress {
    action     = "allow"
    rule_no = 1
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_block = "0.0.0.0/0"
  }
  
  egress {
    action     = "allow"
    rule_no = 1
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_block = "0.0.0.0/0"
  }
  
  
}

resource "aws_network_acl" "dummy_default_acl_VPC1" {
  vpc_id = aws_vpc.VPC1.id

  #Dummy Default ACL VPC1

  tags = {
    Name = "Default ACL"
  }
}

resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.VPC1.id
  subnet_ids = [aws_subnet.subnet1_VPC1.id, aws_subnet.subnet4_VPC1.id]
  
  
  ingress {
    action     = "allow"
    rule_no = 1
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_block = "192.168.0.2/32"
  }

  ingress {
    action     = "allow"
    rule_no = 10
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  
  ingress {
    action     = "allow"
    rule_no = 30
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  
  # ingress {
  #   action     = "allow"
  #   rule_no = 50
  #   from_port   = 8443
  #   to_port     = 8443
  #   protocol    = "tcp"
  #   cidr_block = "0.0.0.0/0"
  # }
  
  ingress {
    action     = "allow"
    rule_no = 50
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  
  ingress {
    action     = "allow"
    rule_no = 60
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    cidr_block = "0.0.0.0/0"
  }
  
  ingress {
    action     = "allow"
    rule_no = 199
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block = "3.223.132.252/32"
  }
  
  egress {
    action     = "allow"
    rule_no = 1
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_block = "192.168.0.2/32"
  }
  
  egress {
    action     = "allow"
    rule_no = 10
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  
  egress {
    action     = "allow"
    rule_no = 30
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  
  
  # egress {
  #   action     = "allow"
  #   rule_no = 50
  #   from_port   = 8443
  #   to_port     = 8443
  #   protocol    = "tcp"
  #   cidr_block = "0.0.0.0/0"
  # }
  
  egress {
    action     = "allow"
    rule_no = 50
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  
  egress {
    action     = "allow"
    rule_no = 60
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    cidr_block = "0.0.0.0/0"
  }
  
  egress {
    action     = "allow"
    rule_no = 298
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet5_VPC1.cidr_block
  }
  
  egress {
    action     = "allow"
    rule_no = 299
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet2_VPC1.cidr_block
  }
  
  egress {
    action     = "allow"
    rule_no = 300
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block = "3.223.132.252/32"
    }
  
   tags = {
    Name = "AppLB/NATinstance Public Subnet ACL"
  }
  
}

resource "aws_network_acl" "private_subnet_1_acl" {
  vpc_id = aws_vpc.VPC1.id
  subnet_ids = [aws_subnet.subnet2_VPC1.id, aws_subnet.subnet5_VPC1.id]
  
  ingress {
    action     = "allow"
    rule_no = 1
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_block = "192.168.0.2/32"
  }
  
  ingress {
    action     = "allow"
    rule_no = 10
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet1_VPC1.cidr_block
  }
  
  ingress {
    action     = "allow"
    rule_no = 11
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet4_VPC1.cidr_block
  }
  
  ingress {
    action     = "allow"
    rule_no = 30
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet1_VPC1.cidr_block
  }
  
  ingress {
    action     = "allow"
    rule_no = 31
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet4_VPC1.cidr_block
  }
  
  # ingress {
  #   action     = "allow"
  #   rule_no = 50
  #   from_port   = 8443
  #   to_port     = 8443
  #   protocol    = "tcp"
  #   cidr_block = aws_subnet.subnet1_VPC1.cidr_block
  # }
  
  # ingress {
  #   action     = "allow"
  #   rule_no = 51
  #   from_port   = 8443
  #   to_port     = 8443
  #   protocol    = "tcp"
  #   cidr_block = aws_subnet.subnet4_VPC1.cidr_block
  # }
  
   ingress {
    action     = "allow"
    rule_no = 50
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet1_VPC1.cidr_block
  }
  
  ingress {
    action     = "allow"
    rule_no = 51
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet4_VPC1.cidr_block
  }
  
  ingress {
    action     = "allow"
    rule_no = 60
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    cidr_block = aws_subnet.subnet1_VPC1.cidr_block
  }
  
  ingress {
    action     = "allow"
    rule_no = 61
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    cidr_block = aws_subnet.subnet4_VPC1.cidr_block
  }
  
  # ingress {
  #   action     = "allow"
  #   rule_no = 70
  #   from_port   = 20
  #   to_port     = 21
  #   protocol    = "tcp"
  #   cidr_block = "192.168.0.0/16"
  # }
  
  ingress {
    action     = "allow"
    rule_no = 299
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block = "3.223.132.252/32"
  }
  
  egress {
    action     = "allow"
    rule_no = 1
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_block = "192.168.0.2/32"
  }
  
  egress {
    action     = "allow"
    rule_no = 10
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  
  egress {
    action     = "allow"
    rule_no = 30
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet1_VPC1.cidr_block
  }
  
  egress {
    action     = "allow"
    rule_no = 31
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet4_VPC1.cidr_block
  }
  
  # egress {
  #   action     = "allow"
  #   rule_no = 50
  #   from_port   = 8080
  #   to_port     = 8080
  #   protocol    = "tcp"
  #   cidr_block = aws_subnet.subnet1_VPC1.cidr_block
  # }
  
  # egress {
  #   action     = "allow"
  #   rule_no = 51
  #   from_port   = 8080
  #   to_port     = 8080
  #   protocol    = "tcp"
  #   cidr_block = aws_subnet.subnet4_VPC1.cidr_block
  # }
  
  egress {
    action     = "allow"
    rule_no = 50
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet1_VPC1.cidr_block
  }
  
  egress {
    action     = "allow"
    rule_no = 51
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_block = aws_subnet.subnet4_VPC1.cidr_block
  }
  
  egress {
    action     = "allow"
    rule_no = 60
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    cidr_block = aws_subnet.subnet1_VPC1.cidr_block
  }
  
  egress {
    action     = "allow"
    rule_no = 61
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    cidr_block = aws_subnet.subnet4_VPC1.cidr_block
  }
  
  egress {
    action     = "allow"
    rule_no = 299
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block = "3.223.132.252/32"
  }
  
  tags = {
    Name = "Webservers Private Subnet ACL"
  }
}

#Hey whats up
#Got the CICD pipeline working, just with no acls or sec groups
#Working on that right now

resource "aws_network_acl" "private_subnet_2_acl" {
  vpc_id = aws_vpc.VPC1.id
  subnet_ids = [aws_subnet.subnet3_VPC1.id, aws_subnet.subnet6_VPC1.id ]

  egress {
    protocol   = "-1"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  
  ingress {
    protocol   = "-1"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Private"
  }
}
