resource "aws_default_security_group" "default_security_group_VPC1" {
  vpc_id = aws_vpc.VPC1.id
  
  ingress {
    description = "TCP HTTP Traffic from internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "UDP HTTP Traffic from internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_security_group" "alb_secgrp" {
  name        = "ALB Security Group"
  description = "Security Group for Application Load Balancer"
  vpc_id      = aws_vpc.VPC1.id
  
  ingress {
    description = "DNS Traffic from Route53 Resolver"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["192.168.0.2/32"]
  }

  ingress {
    description = "TCP HTTP Traffic from Anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "UDP HTTP Traffic from Anywhere"
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "TCP HTTPS Traffic from Anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "TCP Ephemeral Traffic to Web Servers"
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.subnet2_VPC1.cidr_block,
      aws_subnet.subnet5_VPC1.cidr_block
    ]
  }
  
  egress {
    description = "UDP Ephemeral Traffic to Web Servers"
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = [
      aws_subnet.subnet2_VPC1.cidr_block,
      aws_subnet.subnet5_VPC1.cidr_block
    ]
  }
  
  egress {
    description = "DNS Traffic to Route53 Resolver"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["192.168.0.2/32"]
  }
  
  egress {
    description = "TCP HTTP Traffic to Web Servers"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.subnet2_VPC1.cidr_block,
      aws_subnet.subnet5_VPC1.cidr_block
    ]
  }
  
  #   egress {
  #   description = "CodeDeploy Test Traffic to Web Servers"
  #   from_port   = 8443
  #   to_port     = 8443
  #   protocol    = "tcp"
  #   cidr_blocks = [
  #     aws_subnet.subnet2_VPC1.cidr_block,
  #     aws_subnet.subnet5_VPC1.cidr_block
  #   ]
  # }
  
  egress {
    description = "TCP HTTPS Traffic to Web Servers"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.subnet2_VPC1.cidr_block,
      aws_subnet.subnet5_VPC1.cidr_block
    ]
  }
  
  # egress {
  #   description = "TCP Ephemeral Traffic to Web Servers"
  #   from_port   = 1024
  #   to_port     = 65535
  #   protocol    = "tcp"
  #   cidr_blocks = [
  #     aws_subnet.subnet2_VPC1.cidr_block,
  #     aws_subnet.subnet5_VPC1.cidr_block
  #   ]
  # }
  
  # egress {
  #   description = "UDP Ephemeral Traffic to Web Servers"
  #   from_port   = 1024
  #   to_port     = 65535
  #   protocol    = "udp"
  #   cidr_blocks = [
  #     aws_subnet.subnet2_VPC1.cidr_block,
  #     aws_subnet.subnet5_VPC1.cidr_block
  #   ]
  # }

  tags = {
    Name = "AppLB Security Group"
  }
}

resource "aws_security_group" "web_instance_secgrp" {
  name        = "Web Security Group"
  description = "Security Group for NAT instances"
  vpc_id      = aws_vpc.VPC1.id
  
  ingress {
    description = "DNS Traffic from Route53 Resolvere"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["192.168.0.2/32"]
  }
  
  ingress {
    description = "TCP HTTP Traffic/Health Check from appLB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_secgrp.id]
  }
  
  # ingress {
  #   description = "CodeDeploy Test Traffic from appLB"
  #   from_port   = 8443
  #   to_port     = 8443
  #   protocol    = "tcp"
  #   security_groups = [aws_security_group.alb_secgrp.id]
  # }
  
  ingress {
    description = "TCP HTTPS Traffic from appLB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_secgrp.id]
  }
  
  ingress {
    description = "TCP Ephemeral Traffic from appLB "
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_secgrp.id]
  }
  
  ingress {
    description = "UDP Ephemeral Traffic from appLB "
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    security_groups = [aws_security_group.alb_secgrp.id]
  }
  
  ingress {
    description = "SSH Traffic from NAT servers"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.subnet1_VPC1.cidr_block,
      aws_subnet.subnet4_VPC1.cidr_block,
    ]
  }
  
  # ingress {
  #   description = "TCP Ephemeral Traffic from AppLB"
  #   from_port   = 1024
  #   to_port     = 65535
  #   protocol    = "tcp"
  #   cidr_blocks = [
  #     aws_subnet.subnet2_VPC1.cidr_block,
  #     aws_subnet.subnet5_VPC1.cidr_block,
  #   ]
  # }
  
  # ingress {
  #   description = "UDP Ephemeral Traffic from AppLB"
  #   from_port   = 1024
  #   to_port     = 65535
  #   protocol    = "udp"
  #   cidr_blocks = [
  #     aws_subnet.subnet2_VPC1.cidr_block,
  #     aws_subnet.subnet5_VPC1.cidr_block,
  #   ]
  # }
  
  # ingress {
  #   description = "TCP FTP Traffic from CodeDeploy Endpoint"
  #   from_port   = 20
  #   to_port     = 21
  #   protocol    = "tcp"
  #   cidr_blocks = [
  #     aws_subnet.subnet2_VPC1.cidr_block,
  #     aws_subnet.subnet5_VPC1.cidr_block,
  #   ]
  # }
  
  # ingress {
  #   description = "UDP FTP Traffic from CodeDeploy Endpoint"
  #   from_port   = 20
  #   to_port     = 21
  #   protocol    = "udp"
  #   cidr_blocks = [
  #     aws_subnet.subnet2_VPC1.cidr_block,
  #     aws_subnet.subnet5_VPC1.cidr_block,
  #   ]
  # }
  
  egress {
    description = "DNS Traffic to Route53 Resolver"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["192.168.0.2/32"]
  }
 
  egress {
    description = "TCP HTTP Traffic to NAT Servers"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.subnet1_VPC1.cidr_block,
      aws_subnet.subnet4_VPC1.cidr_block,
    ]
  }
  
  egress {
    description = "TCP HTTPS Traffic to NAT Servers"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.subnet1_VPC1.cidr_block,
      aws_subnet.subnet4_VPC1.cidr_block,
    ]
  }
  
  # egress {
  #   description = "TCP HTTPS Traffic to NAT Servers"
  #   from_port   = 8443
  #   to_port     = 8443
  #   protocol    = "tcp"
  #   cidr_blocks = [
  #     aws_subnet.subnet1_VPC1.cidr_block,
  #     aws_subnet.subnet4_VPC1.cidr_block,
  #   ]
  # }
  
  egress {
    description = "TCP Ephemeral Traffic to NAT Servers"
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.subnet1_VPC1.cidr_block,
      aws_subnet.subnet4_VPC1.cidr_block,
    ]
  }
  
  egress {
    description = "UDP Ephemeral Traffic to NAT Servers"
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = [
      aws_subnet.subnet1_VPC1.cidr_block,
      aws_subnet.subnet4_VPC1.cidr_block,
    ]
  }
  
  egress {
    description = "TCP HTTPS Traffic to CodeDeploy Endpoint"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.subnet2_VPC1.cidr_block,
      aws_subnet.subnet5_VPC1.cidr_block,
    ]
  }
  
  tags = {
    Name = "Web Server Security Group"
  }
}

      resource "aws_security_group" "webserver_codedeploy_endpoint_secgrp" {
        name        = "codedeployendpointsecgrp"
        description = "Permits access to Webservers from CodeDeploy Endpoint"
        vpc_id      = aws_vpc.VPC1.id
          
          ingress {
            description = "TCP HTTPS Traffic from Web Servers"
            from_port   = 443
            to_port     = 443
            protocol    = "tcp"
             cidr_blocks = [
                aws_subnet.subnet2_VPC1.cidr_block,
                aws_subnet.subnet5_VPC1.cidr_block,
              ]
          }
           
          egress {
            description = "TCP HTTPS Traffic to CodeDeploy Service"
            from_port   = 443
            to_port     = 443
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
          }
        
        tags = {
            Name = "CodeDeploy Endpoint Security Group"
          }
        }  

resource "aws_security_group" "nat_instance_secgrp" {
  name        = "NAT Security Group"
  description = "Security Group for NAT instances"
  vpc_id      = aws_vpc.VPC1.id
  
  ingress {
    description = "DNS Traffic from Route53 Resolver"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    security_groups = ["192.168.0.2/32"]
  }
  
  # ingress {
  #   description = "TCP HTTP Traffic from Web Servers"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   security_groups = [aws_security_group.web_instance_secgrp.id]
  # }
  
  # ingress {
  #   description = "TCP HTTPS Traffic from Web Servers"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   security_groups = [aws_security_group.web_instance_secgrp.id]
  # }
  
  ingress {
    description = "TCP Ephemeral Traffic from Web Servers"
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    security_groups = [aws_security_group.web_instance_secgrp.id]
  }
  
  ingress {
    description = "UDP Ephemeral Traffic from Web Servers"
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    security_groups = [aws_security_group.web_instance_secgrp.id]
  }
  
  ingress {
    description = "SSH Traffic from Bastion Host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["3.223.132.252/32"]
      
  }

  egress {
    description = "TCP HTTP Traffic to Anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "TCP HTTPS Traffic to Anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "TCP Ephemeral Traffic to Anywhere"
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "UDP Ephemeral Traffic to Anywhere"
    from_port   = 1024
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "DNS Traffic to Route53 Resolver"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["192.168.0.2/32"]
  }
  
  egress {
    description = "SSH Traffic to Web Servers"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "3.223.132.252/32",
      aws_subnet.subnet2_VPC1.cidr_block,
      aws_subnet.subnet5_VPC1.cidr_block,
      ]
  }

  tags = {
    Name = "NAT Security Group"
  }
}