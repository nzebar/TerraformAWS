resource "aws_codedeploy_app" "appPRODUCTION" {
  name = "Production-App"
}

resource "aws_codedeploy_deployment_config" "PRODUCTIONhealth" {
  deployment_config_name = "PRODUCTIONhealth"
  compute_platform = "Server"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 1
  }
  
  # traffic_routing_config {
  #   type = "TimeBasedLinear"
    
  #     time_based_linear {
  #       interval = 1
  #       percentage = 50
  #     }
  # }
}

resource "aws_codedeploy_deployment_group" "deploymentgroupPRODUCTION" {
  app_name               = aws_codedeploy_app.appPRODUCTION.name
  deployment_group_name  = "Website-Production-Deployment"
  service_role_arn       = aws_iam_role.PRODUCTIONcodedeployIAMRole.arn
  deployment_config_name = aws_codedeploy_deployment_config.PRODUCTIONhealth.deployment_config_name
  
  ec2_tag_set {
    ec2_tag_filter {
      key   = "ProdServer"
      value = "ProductionServer"
      type  = "KEY_AND_VALUE"
    }
  }
  
  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type = "IN_PLACE" 
  }
  
#   blue_green_deployment_config {
  
#     deployment_ready_option{
#       action_on_timeout = "CONTINUE_DEPLOYMENT"
#     }
    
#     green_fleet_provisioning_option{
#       action = "DISCOVER_EXISTING"
#     }
  
#     terminate_blue_instances_on_deployment_success{
#       action = "TERMINATE"
#       termination_wait_time_in_minutes = 1
#     }  
#   }



  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.target_group_1_HTTP.name
    }
  }
#     target_group_pair_info {
#       target_group {
#         name = aws_lb_target_group.target_group_1_HTTP.name
#         }
# #       target_group {
# #         name = aws_lb_target_group.target_group_2_HTTP.name
# #         }
#       prod_traffic_route {
#         listener_arns = [aws_lb_listener.application_loadbalancer_1_listener.arn]
#       }
      
# #       test_traffic_route {
# #         listener_arns = [aws_lb_listener.application_loadbalancer_2_listener.arn]
# #       }
#     }
# } 
 
  trigger_configuration {
    trigger_events     = ["DeploymentFailure"]
    trigger_name       = "CodeDeploySNS"
    trigger_target_arn = aws_sns_topic.CodeDeploySNS.arn
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = ["deployalarmPRODUCTION"]
    enabled = true
  }
}

resource "aws_sns_topic" "CodeDeploySNS" {
  name = "CodeDeploySNS"
}

resource "aws_vpc_endpoint" "codedeploy_endpoint" {
  vpc_id            = aws_vpc.VPC1.id
  service_name      = "com.amazonaws.us-east-1.codedeploy"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  
  subnet_ids = [
      aws_subnet.subnet2_VPC1.id,
      aws_subnet.subnet5_VPC1.id
  ]
  
  #policy = aws_iam_role_policy.CodedeployCodepipelinePolicy.policy
  security_group_ids = [aws_default_security_group.default_security_group_VPC1.id]
  #security_group_ids = [aws_security_group.webserver_codedeploy_endpoint_secgrp.id]
}

resource "aws_vpc_endpoint" "codedeploy_endpoint_commands_secure" {
  vpc_id            = aws_vpc.VPC1.id
  service_name      = "com.amazonaws.us-east-1.codedeploy-commands-secure"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  
  subnet_ids = [
      aws_subnet.subnet2_VPC1.id,
      aws_subnet.subnet5_VPC1.id
  ]
  
  #policy = aws_iam_role_policy.CodedeployCodepipelinePolicy.policy
  security_group_ids = [aws_default_security_group.default_security_group_VPC1.id]
  #security_group_ids = [aws_security_group.webserver_codedeploy_endpoint_secgrp.id]
}

# resource "aws_key_pair" "deployer" {
#   key_name   = "deployer-key"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
# }