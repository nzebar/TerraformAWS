resource "aws_route53_zone" "public_dns_zone" {
  name = "nutsandbolts-online.us.to"
  
  force_destroy = true
}

    resource "aws_route53_record" "alias_record_applb_1" {
      zone_id = aws_route53_zone.public_dns_zone.zone_id
      name    = "www.nutsandbolts-online.us.to"
      type    = "A"
    
      alias {
        name                   = aws_lb.application_loadbalancer_1.dns_name
        zone_id                = aws_lb.application_loadbalancer_1.zone_id
        evaluate_target_health = true
      }
    }
    
    resource "aws_route53_record" "alias_record_applb_2" {
      zone_id = aws_route53_zone.public_dns_zone.zone_id
      name    = "nutsandbolts-online.us.to"
      type    = "A"
    
      alias {
        name                   = aws_lb.application_loadbalancer_1.dns_name
        zone_id                = aws_lb.application_loadbalancer_1.zone_id
        evaluate_target_health = true
      }
    }
    
    resource "aws_route53_record" "www_alias_record_nat_servers_useast1a" {
      zone_id = aws_route53_zone.public_dns_zone.zone_id
      name    = "www.nutsandbolts-online.us.to"
      type    = "A"
    
      alias {
        name                   = aws_instance.nat_useast1a.private_dns #DNS Hostname set for NAT Server AMI
        zone_id                = aws_route53_zone.private_dns_zone.zone_id
        evaluate_target_health = true
      }
    }
    
            resource "aws_route53_health_check" "www_alias_record_nat_servers_useast1a_health_check" {
              failure_threshold = "3"
              fqdn              = aws_route53_record.www_alias_record_nat_servers_useast1a.fqdn
              port              = 443
              request_interval  = "10"
              resource_path     = "/"
              search_string     = aws_instance.nat_useast1a.private_dns
              type              = "HTTPS_STR_MATCH"
            }
            
    resource "aws_route53_record" "www_alias_record_nat_servers_useast1b" {
      zone_id = aws_route53_zone.public_dns_zone.zone_id
      name    = "www.nutsandbolts-online.us.to"
      type    = "A"
    
      alias {
        name                   = aws_instance.nat_useast1a.private_dns  #DNS Hostname set for NAT Server AMI
        zone_id                = aws_route53_zone.private_dns_zone.zone_id
        evaluate_target_health = true
      }
    }
    
            resource "aws_route53_health_check" "www_alias_record_nat_servers_useast1b_health_check" {
              failure_threshold = "3"
              fqdn              = aws_route53_record.www_alias_record_nat_servers_useast1b.fqdn
              port              = 443
              request_interval  = "10"
              resource_path     = "/"
              search_string     = aws_instance.nat_useast1a.private_dns
              type              = "HTTPS_STR_MATCH"
            }
    
resource "aws_route53_zone" "private_dns_zone" {
  name = "nutsandbolts-online.us.to"

  vpc {
    vpc_id = aws_vpc.VPC1.id
  }
  
  force_destroy = true
}

     resource "aws_route53_record" "root_alias_record_web_servers" {
      zone_id = aws_route53_zone.private_dns_zone.zone_id
      name    = "webserver.nutsandbolts-online.us.to"
      type    = "A"
    
      alias {
        name                   = aws_network_interface.webserver_1_interface.private_dns_name   #DNS Hostname set for Web Server AMI
        zone_id                = aws_route53_zone.private_dns_zone.zone_id
        evaluate_target_health = true
      }
    }
    
            resource "aws_route53_health_check" "root_alias_record_web_servers_health_check" {
              failure_threshold = "3"
              fqdn              = aws_route53_record.root_alias_record_web_servers.fqdn
              port              = 443
              request_interval  = "10"
              resource_path     = "/"
              search_string     = aws_network_interface.webserver_1_interface.private_dns_name
              type              = "HTTPS_STR_MATCH"
            }
    
     resource "aws_route53_record" "alias_record_codedeploy_endpoint" {
      zone_id = aws_route53_zone.private_dns_zone.zone_id
      name    = "codedeploy.us-east-1.amazonaws.com"
      type    = "A"
    
      alias {
        name                   = data.aws_network_interface.get_codedeploy_endpoint_private_dns_name.private_dns_name
        zone_id                = aws_route53_zone.private_dns_zone.zone_id
        evaluate_target_health = true
      }
    }
    
          resource "aws_route53_record" "a_record_codedeploy_endpoint" {
            zone_id = aws_route53_zone.private_dns_zone.zone_id
            name    = data.aws_network_interface.get_codedeploy_endpoint_private_dns_name.private_dns_name
            type    = "A"
          
            records = data.aws_network_interface.get_codedeploy_endpoint_private_dns_name.private_ips
          }
  
          data "aws_network_interface" "get_codedeploy_endpoint_private_dns_name" {
            id = aws_vpc_endpoint.codedeploy_endpoint.id
          }
    
          resource "aws_route53_health_check" "alias_record_codedeploy_endpoint_1_health_check" {
            failure_threshold = "3"
            fqdn              = data.aws_network_interface.get_codedeploy_endpoint_private_dns_name.private_dns_name
            port              = 443
            request_interval  = "10"
            resource_path     = "/"
            search_string     = data.aws_network_interface.get_codedeploy_endpoint_private_dns_name.private_dns_name
            type              = "HTTPS_STR_MATCH"
          }
    
    resource "aws_route53_record" "alias_record_codedeploy_endpoint_commands_secure" {
      zone_id = aws_route53_zone.private_dns_zone.zone_id
      name    = "codedeploy-commands-secure.us-east-1.amazonaws.com"
      type    = "A"
      
    
      alias {
        name                   = data.aws_network_interface.get_codedeploy_endpoint_commands_secure_private_dns_name.private_dns_name
        zone_id                = aws_route53_zone.private_dns_zone.zone_id
        evaluate_target_health = true
      }
    }
    
          resource "aws_route53_record" "a_record_codedeploy_endpoint_commands_secure" {
            zone_id = aws_route53_zone.private_dns_zone.zone_id
            name    = data.aws_network_interface.get_codedeploy_endpoint_commands_secure_private_dns_name.private_dns_name
            type    = "A"
          
            records = data.aws_network_interface.get_codedeploy_endpoint_commands_secure_private_dns_name.private_ips
          }
    
          data "aws_network_interface" "get_codedeploy_endpoint_commands_secure_private_dns_name" {
            id = aws_vpc_endpoint.codedeploy_endpoint_commands_secure.id
          }
    
            resource "aws_route53_health_check" "alias_record_codedeploy_endpoint_2_health_check" {
              failure_threshold = "3"
              fqdn              = data.aws_network_interface.get_codedeploy_endpoint_commands_secure_private_dns_name.private_dns_name
              port              = 443
              request_interval  = "10"
              resource_path     = "/"
              search_string     = data.aws_network_interface.get_codedeploy_endpoint_commands_secure_private_dns_name.private_dns_name
              type              = "HTTPS_STR_MATCH"
            }



    