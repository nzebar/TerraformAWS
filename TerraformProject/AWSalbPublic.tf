resource "aws_lb" "application_loadbalancer_1" {
  name               = "Application-LoadBalancer-1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_default_security_group.default_security_group_VPC1.id]
  #security_groups    = [aws_security_group.alb_secgrp.id]
  subnets            = [
                        aws_subnet.subnet1_VPC1.id,
                        aws_subnet.subnet4_VPC1.id,
                       ]
  enable_cross_zone_load_balancing = true
  enable_deletion_protection = false
  drop_invalid_header_fields = false
  enable_http2 = true
  
  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "target_group_1_HTTP" {
  name     = "target-group-1"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.VPC1.id
  deregistration_delay = 5
  
  health_check {
            enabled = true
            interval = 10
            path = "/"
            port = 80
            protocol = "HTTP"
            timeout = 9
            healthy_threshold = 2
            unhealthy_threshold = 2
            matcher = 200
        }
}

        resource "aws_lb_target_group_attachment" "targetgroup1_attachment_1" {
        target_group_arn = aws_lb_target_group.target_group_1_HTTP.arn
        target_id = aws_instance.webserver_1_PRODUCTION.id
        port             = 80
        }
        
        resource "aws_lb_target_group_attachment" "targetgroup1_attachment_2" {
        target_group_arn = aws_lb_target_group.target_group_1_HTTP.arn
        target_id = aws_instance.webserver_2_PRODUCTION.id
        port             = 80
        }
        
        
resource "aws_lb_listener" "application_loadbalancer_listener_codedeploy_80" {
  load_balancer_arn = aws_lb.application_loadbalancer_1.arn
  port              = "80"
  protocol          = "HTTP"

    default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  }
  
resource "aws_lb_listener" "application_loadbalancer_listener_codedeploy_443" {
  load_balancer_arn = aws_lb.application_loadbalancer_1.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_iam_server_certificate.applb_iam_server_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_1_HTTP.arn
  }
}

        resource "aws_lb_listener_rule" "codedeploy_443_traffic" {
          listener_arn = aws_lb_listener.application_loadbalancer_listener_codedeploy_443.arn
          priority     = 298
        
          action {
            type             = "forward"
            target_group_arn = aws_lb_target_group.target_group_1_HTTP.arn
          }
        
          condition {
            host_header {
              values = ["codedeploy.amazonaws.com"]
            }
          }
        }  
  
resource "aws_lb_listener" "application_loadbalancer_listener_codedeploy_8443" {
  load_balancer_arn = aws_lb.application_loadbalancer_1.arn
  port              = "8443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_iam_server_certificate.applb_iam_server_cert.arn

  default_action {
    type             = "fixed-response"
    
    fixed_response {
      content_type = "text/plain"
      message_body = "Apologies...You opened the wrong door."
      status_code  = "200"
    }
  }
}

        resource "aws_lb_listener_rule" "codedeploy_8443_traffic" {
          listener_arn = aws_lb_listener.application_loadbalancer_listener_codedeploy_8443.arn
          priority     = 298
        
          action {
            type             = "redirect"
            
            redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
          }
        }
        
          condition {
            host_header {
              values = ["codedeploy.amazonaws.com"]
            }
          }
        }
        
resource "aws_iam_server_certificate" "applb_iam_server_cert" {
  name             = "applb-iam-server-cert"
  certificate_body = file("webservers-cert.pem")
  private_key      = file("webservers-cert-key.pem")
  certificate_chain = file("webservers-cert-chain.pem")
}
