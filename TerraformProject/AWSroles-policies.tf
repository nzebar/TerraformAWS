# Role for CodePipeline 
resource "aws_iam_role" "codepipeline_role_webserver_production" {
  name = "Codepipeline_Webserver_Production"

  assume_role_policy =<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service" : "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#AWS Policy for CodePipeline Role
resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline_policy"
  role = aws_iam_role.codepipeline_role_webserver_production.id
  
  policy =<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
        {
            "Action":"codepipeline:*",
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeInstanceStatus",
                "ec2:TerminateInstances",
                "tag:GetResources",
                "sns:Publish",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeInstanceHealth",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:RegisterTargets",
                "elasticloadbalancing:DeregisterTargets",
                "cloudwatch:DescribeAlarms"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "appconfig:StartDeployment",
                "appconfig:StopDeployment",
                "appconfig:GetDeployment"
            ],
            "Resource": "*"
        },
        {
            "Action": [
              "s3:*"
            ],
            "Resource": [
              "${aws_s3_bucket.s3_productionEast1.arn}",
              "${aws_s3_bucket.s3_productionEast1.arn}/*"
            ],
            "Effect": "Allow"
        },
        {
            "Effect": "Allow",
            "Action": [
              "s3:List*",
              "s3:Put*",
              "s3:Get*"
            ],
            "Resource": [
              "${aws_s3_bucket.s3_productionEast1.arn}",
              "${aws_s3_bucket.s3_productionEast1.arn}/*"
            ]
        },
        {
            "Action": [
              "kms:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codedeploy:CreateDeployment",
                "codedeploy:GetApplication",
                "codedeploy:GetApplicationRevision",
                "codedeploy:GetDeployment",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:RegisterApplicationRevision"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "ec2:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codecommit:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codebuild:BatchGetBuilds",
                "codebuild:StartBuild",
                "codebuild:BatchGetBuildBatches",
                "codebuild:StartBuildBatch"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}
        
#AWS Role for CodeBuild        
resource "aws_iam_role" "PRODUCTIONcodebuildIAMrole" {
  name = "PRODUCTIONcodebuildIAMrole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#AWS Policy for CodeBuild Role
resource "aws_iam_role_policy" "PRODUCTIONcodebuildIAMpolicy" {
  role = aws_iam_role.PRODUCTIONcodebuildIAMrole.name
  
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [ "ec2:*"],
      "Resource": "*"
    },
    {
            "Action": [
                "codecommit:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterfacePermission"
      ],
      "Resource": ["*"],
      "Condition": {
        "StringEquals": {
          "ec2:Subnet": "*",
          "ec2:AuthorizedService": "codebuild.amazonaws.com"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.s3_productionEast1.arn}",
        "${aws_s3_bucket.s3_productionEast1.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [ 
      "s3:Put*",
      "s3:List*",
      "s3:Get*"
      ],
      "Resource": [
        "${aws_s3_bucket.s3_productionEast1.arn}",
        "${aws_s3_bucket.s3_productionEast1.arn}/*"
      ]
    },
    {
      "Action": [
        "kms:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Effect": "Allow",
      "Action": [ "secretsmanager:GetSecretValue"],
      "Resource": "*"
    }
  ]
}
POLICY
}
        
#AWS Rolde for CodeDeploy
resource "aws_iam_role" "PRODUCTIONcodedeployIAMRole" {
  name = "PRODUCTIONcodedeployIAMRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
      "Service": "codepipeline.amazonaws.com",
      "Service": "codedeploy.us-east-1.amazonaws.com",
      "Service": "sns.amazonaws.com"
      },
      "Action":[ "sts:AssumeRole"]
      }
     ] 
    }
EOF
}

#AWS Policy for CodeDeploy Endpoint
resource "aws_iam_role_policy" "CodedeployCodepipelinePolicy" {
  role       = aws_iam_role.PRODUCTIONcodedeployIAMRole.name
  
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "codedeploy:Batch*",
                "codedeploy:CreateDeployment",
                "codedeploy:Get*",
                "codedeploy:List*",
                "codedeploy:RegisterApplicationRevision"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
      "Action": [
        "kms:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
        },
        {
            "Effect": "Allow",
            "Action": [
                "tag:GetResources",
                "sns:Publish",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeInstanceHealth",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:RegisterTargets",
                "elasticloadbalancing:DeregisterTargets",
                "cloudwatch:DescribeAlarms"
            ],
            "Resource": "*"
        },
        {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceStatus",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs"
      ],
      "Resource": "*"
    },
        {
      "Effect": "Allow",
      "Action": [ 
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListBucket"
      ],
      "Resource": [
        "${aws_s3_bucket.s3_productionEast1.arn}",
        "${aws_s3_bucket.s3_productionEast1.arn}/*"
      ]
    }
    ]
}
POLICY
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2IAMRole.name
}

resource "aws_iam_role" "ec2IAMRole" {
  name = "ec2-IAMRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
      "Service": "codepipeline.amazonaws.com",
      "Service": "codedeploy.us-east-1.amazonaws.com",
      "Service": "ec2.amazonaws.com",
      "Service": "s3.amazonaws.com"
      },
      "Action":[ "sts:AssumeRole"]
      }
     ] 
    }
EOF
}

resource "aws_iam_role_policy_attachment" "codedeploy_policy_attachment" {
  role       = aws_iam_role.ec2IAMRole.name
  policy_arn = aws_iam_policy.ec2CodeDeployPolicy.arn
}

resource "aws_iam_policy" "ec2CodeDeployPolicy" {
  name       = "EC2codedeployPolicy"
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeNetworkAcls",
          "ec2:DescribeRouteTables",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcEndpointConnection",
          "ec2:DescribeVpcEndpointConnections",
          "ec2:DescribeVpcEndpointConnectionNotifications",
          "ec2:DescribeVpcEndpointServicePermissions",
          "ec2:DescribeVpcEndpointServices",
          "ec2:AcceptVpcEndpointConnections",
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StartVpcEndpointServicePrivateDnsVerification",
          "ec2:StopInstances"
         ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "tag:GetResources",
        "sns:Publish",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeInstanceHealth",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:DeregisterTargets",
        "cloudwatch:DescribeAlarms"
        ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codedeploy-commands-secure:GetDeploymentSpecification",
        "codedeploy-commands-secure:PollHostCommand",
        "codedeploy-commands-secure:PutHostCommandAcknowledgement",
        "codedeploy-commands-secure:PutHostCommandComplete"
      ],
      "Resource": "*"
    },
    {
    "Effect": "Allow",
    "Action": [
       "s3:ListBucket",
       "s3:ListBucketVersions",
       "s3:GetBucketAcl",
       "s3:GetBucketLocation",
       "s3:GetBucketOwnershipControls",
       "s3:GetBucketPolicy",
       "s3:GetBucketPolicyStatus",
       "s3:GetBucketVersioning",
       "s3:GetEncryptionConfiguration",
       "s3:GetObject",
       "s3:GetObjectAcl",
       "s3:GetObjectVersion",
       "s3:GetObjectVersionAcl"
    ],
    "Resource": [
        "${aws_s3_bucket.s3_productionEast1.arn}",
        "${aws_s3_bucket.s3_productionEast1.arn}/*",
        "arn:aws:s3:::aws-codedeploy-us-east-1",
        "arn:aws:s3:::aws-codedeploy-us-east-1/*"
      ]
    },
    {
    "Effect": "Allow",
    "Action": [
      "kms:*"
    ],
    "Resource": "*"
    }
  ]
}
EOF
}



# resource "aws_iam_policy" "codedeploy_endpoint_interface_policy" {
#   name        = "CodeDeployEndpointInterfacePolicy"
#   path        = "/"
#   description = "CodeDeploy Endpoint Interface Policy"

#   policy = <<POLICY
# {
# "Version": "2012-10-17",
# "Statement": [
#     {
#     "Effect": "Allow",
#     "Action": [
#         "codedeploy:Batch*",
#         "codedeploy:CreateDeployment",
#         "codedeploy:Get*",
#         "codedeploy:List*",
#         "codedeploy:RegisterApplicationRevision"
#     ],
#     "Resource": "*",
#     "Sid": ""
#     },
#     {
#     "Effect": "Allow",
#     "Action": [
#         "kms:*"
#     ],
#     "Resource": "*",
#     "Sid": ""
#     },
#     {
#     "Effect": "Allow",
#     "Action": [
#         "tag:GetResources",
#         "sns:Publish",
#         "elasticloadbalancing:DescribeLoadBalancers",
#         "elasticloadbalancing:DescribeInstanceHealth",
#         "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
#         "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
#         "elasticloadbalancing:DescribeTargetGroups",
#         "elasticloadbalancing:DescribeTargetHealth",
#         "elasticloadbalancing:RegisterTargets",
#         "elasticloadbalancing:DeregisterTargets",
#         "cloudwatch:DescribeAlarms"
#     ],
#     "Resource": "*",
#     "Sid": ""
#     },
#     {
#     "Effect": "Allow",
#         "Action": [
#         "ec2:DescribeInstances",
#         "ec2:DescribeInstanceStatus",
#         "ec2:DescribeDhcpOptions",
#         "ec2:DescribeNetworkInterfaces",
#         "ec2:DeleteNetworkInterface",
#         "ec2:DescribeSubnets",
#         "ec2:DescribeSecurityGroups",
#         "ec2:DescribeVpcs"
#     ],
#     "Resource": "*",
#     "Sid": ""
#     },
#     {
#     "Effect": "Allow",
#     "Action": [ 
#         "s3:GetObject",
#         "s3:GetObjectVersion",
#         "s3:ListBucket"
#     ],
#     "Resource": [
#         "${aws_s3_bucket.s3_productionEast1.arn}",
#         "${aws_s3_bucket.s3_productionEast1.arn}/*"
#     ],
#     "Sid": ""
#     }
#   ]
# }
# POLICY
# }


#AWS Role for VPC Endpoint interface to be us with CodeDeploy        
# resource "aws_iam_role" "codedeploy_endpoint_interface_role" {
#   name = ""

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#       "Service": "codepipeline.amazonaws.com",
#       "Service": "com.amazonaws.us-east-1.codedeploy",
#       "Service": "sns.amazonaws.com"
#       },
#       "Action":[ "sts:AssumeRole"]
#       }
#      ] 
#     }
# EOF
# }