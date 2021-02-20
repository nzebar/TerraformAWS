
resource "aws_lb" "network_loadbalancer_private" {
  name               = "network-loadbalancer-2"
  internal           = true
  load_balancer_type = "network"
  subnets = [
    aws_subnet.subnet3_VPC1.id,
    aws_subnet.subnet6_VPC1.id
  ]
  
  # subnet_mapping {
  #   subnet_id            = aws_subnet.subnet3_VPC1.id,
  #   private_ipv4_address = "192.168.3.25"
  #   allocation_id =
  # }

  # subnet_mapping {
  #   subnet_id            = aws_subnet.subnet6_VPC1.id,
  #   private_ipv4_address = "192.168.6.25"
  #   allocation_id = 
  # }
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
  ip_address_type = "ipv4"

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "network_loadbalancer_1_listener" {
  load_balancer_arn = aws_lb.network_loadbalancer_private.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_2_mySQL.arn
  }
}

resource "aws_lb_target_group" "target_group_2_mySQL" {
  name     = "target-group-2-mySQL"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.VPC1.id
}

        # resource "aws_lb_target_group_attachment" "targetgroup1_attachment_1" {
        # target_group_arn = aws_lb_target_group.target_group_1_HTTP.arn
        # target_id        = aws_instance.WebAppServer1.id
        # port             = 80
        # availability_zone = "us-east-1a"
        
        # health_check {
        #     enabled = true
        #     interval = 300
        #     path = /var/www/html/index.html
        #     port = 80
        #     protocol = HTTP
        #     timeout = 120
        #     healthy_threshold = 3
        #     unhealthy_threshold = 3
        #     matcher = 200-299
        # }
        # }
        
        # resource "aws_lb_target_group_attachment" "targetgroup1_attachment_1" {
        # target_group_arn = aws_lb_target_group.target_group_1_HTTP.arn
        # target_id        = aws_instance.WebAppServer2.id
        # port             = 80
        # availability_zone = "us-east-1a"
        
        # health_check {
        #     enabled = true
        #     interval = 300
        #     path = /var/www/html/index.html
        #     port = 80
        #     protocol = HTTP
        #     timeout = 120
        #     healthy_threshold = 3
        #     unhealthy_threshold = 3
        #     matcher = 200-299
        # }
        # }
        
        # resource "aws_lb_target_group_attachment" "targetgroup1_attachment_1" {
        # target_group_arn = aws_lb_target_group.target_group_1_HTTP.arn
        # target_id        = aws_instance.WebAppServer3.id
        # port             = 80
        # availability_zone = "us-east-1b"
        
        # health_check {
        #     enabled = true
        #     interval = 300
        #     path = /var/www/html/index.html
        #     port = 80
        #     protocol = HTTP
        #     timeout = 120
        #     healthy_threshold = 3
        #     unhealthy_threshold = 3
        #     matcher = 200-299
        # }
        # }
        
        # resource "aws_lb_target_group_attachment" "targetgroup1_attachment_1" {
        # target_group_arn = aws_lb_target_group.target_group_1_HTTP.arn
        # target_id        = aws_instance.WebAppServer4.id
        # port             = 80
        # availability_zone = "us-east-1b"
        
        # health_check {
        #     enabled = true
        #     interval = 300
        #     path = /var/www/html/index.html
        #     port = 80
        #     protocol = HTTP
        #     timeout = 120
        #     healthy_threshold = 3
        #     unhealthy_threshold = 3
        #     matcher = 200-299
        # }
        # }
        
        # resource "aws_lb_target_group_attachment" "targetgroup1_attachment_1" {
        # target_group_arn = aws_lb_target_group.target_group_1_HTTP.arn
        # target_id        = aws_instance.WebAppServer5.id
        # port             = 80
        # availability_zone = "us-east-1c"
        
        # health_check {
        #     enabled = true
        #     interval = 300
        #     path = /var/www/html/index.html
        #     port = 80
        #     protocol = HTTP
        #     timeout = 120
        #     healthy_threshold = 3
        #     unhealthy_threshold = 3
        #     matcher = 200-299
        # }
        # }
        
        # resource "aws_lb_target_group_attachment" "targetgroup1_attachment_1" {
        # target_group_arn = aws_lb_target_group.target_group_1_HTTP.arn
        # target_id        = aws_instance.WebAppServer6.id
        # port             = 80
        # availability_zone = "us-east-1c"
        
        # health_check {
        #     enabled = true
        #     interval = 300
        #     path = /var/www/html/index.html
        #     port = 80
        #     protocol = HTTP
        #     timeout = 120
        #     healthy_threshold = 3
        #     unhealthy_threshold = 3
        #     matcher = 200-299
        # }
        # }





