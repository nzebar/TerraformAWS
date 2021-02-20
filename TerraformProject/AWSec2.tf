resource "aws_instance" "webserver_1_PRODUCTION" {
  ami           = data.aws_ami.getAMI.id
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  key_name = aws_key_pair.production_key1.key_name
  monitoring = true
  network_interface {
    network_interface_id = aws_network_interface.webserver_1_interface.id
    device_index = 0
  }
}

resource "aws_network_interface" "webserver_1_interface" {
  description = "Interface for webserver 1"
  subnet_id = aws_subnet.subnet2_VPC1.id
  private_ips = ["192.168.2.8"]
  security_groups = [
  aws_default_security_group.default_security_group_VPC1.id,
  #aws_security_group.web_instance_secgrp.id,
  ]
}

resource "aws_ec2_tag" "webserver_1_tag" {
  resource_id = aws_instance.webserver_1_PRODUCTION.id
  key         = "ProdServer"
  value       = "ProductionServer"
}

resource "aws_key_pair" "production_key1" {
  key_name   = "Webserver1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDh26v6jWTq8OutZ1By/MelfxGn8ckgBCcJRX+7e0hDHWobb+FyvvgUdoTekB4GSHC6v+lNCKIeYMLneHT0I3hSa+zIpQvRftH1NEp+Xi+rHd/u55/IzawOV7MVQ0RlVW88THNtf5Zgc82kNOnrKbwRE4bwwenh41XXvwmF+r30vznJB/3KXE1UShlnlxifDcbz60O8M0GVl7qutXlNINkqDj25ddUzybmiGudwlYHuaFYhG2+wkb58NOicLOotlyie+ZIKB+pQQB9JNs2uq3CkmEQyNsuLRDncwDtkIjELog2qC+G8z4cF8GNWOIafzGkSuTcml+Zsv9/zpj4DP2mH ec2-user@boltzwebserver"
}



# data "aws_ami" "getAMI" {
#   executable_users = ["self"]
#   owners           = ["062812664163"]

#   filter {
#     name   = "name"
#     values = ["AMIproduction"]
#   }
# }

# data "aws_ami_ids" "getAMI" {
#   owners = ["062812664163"]
#   executable_users = ["self"]

#   filter {
#     name   = "name"
#     values = ["AMIproduction"]
#   }
# }

#Used to get the ID of the most recent AMI on AWS Console
data "aws_ami" "getAMI" { 
  most_recent      = true
  owners           = ["062812664163"] //Owner of the AMI.
}

# ami-0947d2ba12ee1ff75


resource "aws_instance" "webserver_2_PRODUCTION" {
  ami           = data.aws_ami.getAMI.id
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  key_name = aws_key_pair.production_key2.key_name
  monitoring = true
  network_interface {
    network_interface_id = aws_network_interface.webserver_2_interface.id
    device_index = 0
  }
}

resource "aws_network_interface" "webserver_2_interface" {
  description = "Interface for webserver 2"
  subnet_id = aws_subnet.subnet5_VPC1.id
  private_ips = ["192.168.5.8"]
  security_groups = [
  aws_default_security_group.default_security_group_VPC1.id,
  #aws_security_group.web_instance_secgrp.id,
  ]
}

resource "aws_ec2_tag" "webserver_2_tag" {
  resource_id = aws_instance.webserver_2_PRODUCTION.id
  key         = "ProdServer"
  value       = "ProductionServer"
}

resource "aws_key_pair" "production_key2" {
  key_name   = "Webserver2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7ZzMAsEMAtiSlmkRfuQYVuebsb7YOp2inGxH3SCRtSt+RjeTcsMfUO2ndWs68RTHemECDJjfxrk3PVNr+bHLlwaqdYlVKGLszCqoVGrAlV0zsPa48nchuYVxptJmewHrOeJWSR6IjaSyqPT16AGq8DXBEb+kV/tUrdDQohN5SDynLOjBb3mwoKEoYIuIaWaK+W8PDiN8X/nn9gr1vvTs6aqsCMkglSg/qV+BRUC1fec/RsW/qVqtRpdwxfV2yxvMAuAEknO7pgkcAeIc7Lth5jXYxuyYBkdOoXe7CJMVvoZ66SxIXGUYrpnKXAe8N1EwUebDxIl+UTQjf8O7STY05 ec2-user@boltzwebserver"
}









resource "aws_instance" "nat_useast1a" {
  ami           = "ami-01ef31f9f39c5aaed"
  instance_type = "t2.micro"
  iam_instance_profile = "CICDterraformRole"
  key_name = aws_key_pair.nat_key3.key_name
  monitoring = true
  source_dest_check = false
  subnet_id = aws_subnet.subnet1_VPC1.id
  vpc_security_group_ids  = [aws_default_security_group.default_security_group_VPC1.id]
  #vpc_security_group_ids  = [aws_security_group.nat_instance_secgrp.id]
  private_ip = "192.168.1.5"
  # network_interface {
  #   network_interface_id = aws_network_interface.nat_interface_1.id
  #   device_index = 0
  # }
}

resource "aws_eip" "eip_nat_useast1a" {
  instance = aws_instance.nat_useast1a.id
  vpc      = true
}

# resource "aws_network_interface" "nat_interface_1" {
#   description = "Used to SSH in the network."
#   subnet_id = aws_subnet.subnet1_VPC1.id
#   private_ips = ["192.168.1.120"]
#   security_groups = [aws_security_group.nat_secgrp.id]
# }

# resource "aws_eip" "nat_eip_useast1a" {
#   vpc                       = true
#   network_interface         = aws_network_interface.nat_interface_1.id
#   associate_with_private_ip = "192.168.1.120"
# }

resource "aws_ec2_tag" "nat_useast1a_tag" {
  resource_id = aws_instance.nat_useast1a.id
  key         = "NAT1"
  value       = "Server1"
}

resource "aws_key_pair" "nat_key3" {
  key_name   = "NATserv1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLn98h5WiPgqgQCvWZERWFIU23FNVf+xMcL7igtdzmEYwoRiNcdkuejCmDDT9tTH8/ZweCg8r7dvgctXZIWU9E5S15Plxr/6PeItVVSy01pRbqnYXAEAIVN356kQYyjo9YngyYDCspXQ9moSvXi4AsfUla/P8z6uYOtzlCIASDd/CELTMCOl4jvRMsSlOk/uMmukP+UREpE0JViT2HgHH9hdXybXaJ3CgMejl0jp0vMxadTA0Fa1C+zAKsFtWmnCi+vKqQuyXwxIE/fRdWdTG9+2q6HW3hXBebMGBMXm3zvaDVMHuAnXtbo/BXkj46ewG10KFfNBeCmuzTT6VBaZRv ec2-user@boltzwebserver"
}








resource "aws_instance" "nat_useast1b" {
  ami           = "ami-01ef31f9f39c5aaed"
  instance_type = "t2.micro"
  iam_instance_profile = "CICDterraformRole"
  key_name = aws_key_pair.nat_key2.key_name
  monitoring = true
  source_dest_check = false
  subnet_id = aws_subnet.subnet4_VPC1.id
  vpc_security_group_ids  = [aws_default_security_group.default_security_group_VPC1.id]
 #vpc_security_group_ids  = [aws_security_group.nat_instance_secgrp.id]
  private_ip = "192.168.4.5"
  
  # network_interface {
  #   network_interface_id = aws_network_interface.nat_interface_2.id
  #   device_index = 0
  # }
}

resource "aws_eip" "eip_nat_useast1b" {
  instance = aws_instance.nat_useast1b.id
  vpc      = true
}

# resource "aws_network_interface" "nat_interface_2" {
#   description = "Used to SSH in the network."
#   subnet_id = aws_subnet.subnet3_VPC1.id
#   private_ips = ["192.168.4.120"]
#   security_groups = [aws_security_group.nat_secgrp.id]
# }

# resource "aws_eip" "nat_eip_useast1b" {
#   vpc                       = true
#   network_interface         = aws_network_interface.nat_interface_2.id
#   associate_with_private_ip = "192.168.4.120"
# }

resource "aws_ec2_tag" "nat_useast1b_tag" {
  resource_id = aws_instance.nat_useast1a.id
  key         = "NAT1"
  value       = "Server1"
}

resource "aws_key_pair" "nat_key2" {
  key_name   = "NATserv2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4Bn64B0BwR9HkKsCQGnCJH6hmZCye7PQDWDrcJyhg37HPzTm6EBuGPPellJgLXayytZOW4FD1rUM87+z1UB92vpUhmUHnZVozqarWETDE0N0BgaPjTjdU4v5bGgyDcqTi/KBYTiLI0RALxn8UGGbUVhxfA5Jx7nFOwqPS5NKpCLKXk2rrbWKllmG1h8wScMP5YhPdFQPaYw/1Bk45C6NVGaIVZZ7o2aY1g5f8c6+q2S+i3SB2yDCZGrHzKu3y1VyznAofLWsMVLq/By8cH8Z0N3/Jr8tQtWjxw2n/brsJGlmyobVymEcGvIMwMhHmQndpr7mdXciCR29CQBaqti71 ec2-user@boltzwebserve"
}

