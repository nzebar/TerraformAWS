resource "aws_iam_role" "codedeployIAMrole" {
  name = "codedeployIAMrole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "CodeDeployPolicyAttachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/codedeployIAMrole"
  role       = aws_iam_role.codedeployIAMrole.name
}

resource "aws_codedeploy_app" "appPRODUCTION" {
  name = "appPRODUCTION"
}

resource "aws_sns_topic" "CodeDeploySNS" {
  name = "CodeDeploySNS"
}

resource "aws_codedeploy_deployment_config" "codedeployhealthPRODUCTION" {
  deployment_config_name = "codedeployhealthPRODUCTION"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 1
  }
}

resource "aws_codedeploy_deployment_group" "deploymentgroupPRODUCTION" {
  app_name               = aws_codedeploy_app.appPRODUCTION.name
  deployment_group_name  = "deploymentgroupPRODUCTION"
  service_role_arn       = aws_iam_role.codedeployIAMrole.arn
  deployment_config_name = aws_codedeploy_deployment_config.codedeployhealthPRODUCTION.id
  

  trigger_configuration {
    trigger_events     = ["DeploymentFailure"]
    trigger_name       = "productionFAILURE"
    trigger_target_arn = "CodeDeploySNS"
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
