resource "aws_codepipeline" "CICDproduction" {
  name     = "CICDproduction"
  role_arn = aws_iam_role.productionIAMrole.arn

  artifact_store {
    location = aws_s3_bucket.productionbucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "codecommit"
      category         = "Source"
      owner            = "AWS"
      provider         = "codecommit"
      version          = "1"
      output_artifacts = ["deploy_output"]

      configuration = {
        Owner      = "AWS"
        Repo       = "repo_PRODUCTION"
        Branch     = "master"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "codedeploy"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        ActionMode     = "REPLACE_ON_FAILURE"
        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        OutputFileName = "CreateStackOutput.json"
        StackName      = "MyStack"
        TemplatePath   = "build_output::sam-templated.yaml"
      }
    }
  }
}

resource "aws_s3_bucket" "productionbucket" {
  bucket = "production-bucket"
  acl    = "private"
}

resource "aws_kms_key" "s3keyPRODUCTION" {}

resource "aws_iam_role" "productionIAMrole" {
  name = "productionIAMrole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action":[ "sts:AssumeRole"]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "productionIAMpolicy" {
  name = "productionIAMpolicy"
  role = "productionIAMrole"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    
    {
        
          {
            "Effect": "Allow",
            "Action": [
                "iam:PassRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringEqualsIfExists": {
                    "iam:PassedToService": [
                        "codecommit.amazonaws.com",
                        "codedeploy.amazonaws.com",
                        "ec2.amazonaws.com",
                        "codepipeline.amazonaws.com",
                        "s3.amazonaws.com"
                    ],
                }
            }
         },
  
    	{
      "Effect": "Allow",
      "Action": [
        				"codecommit:CancelUploadArchive",
                "codecommit:GetBranch",
                "codecommit:GetCommit",
                "codecommit:GetRepository",
                "codecommit:GetUploadArchiveStatus",
                "codecommit:UploadArchive"
            ],
      "Resource": ["*"]
    	},
    	
    	
    
    	{
    	      "Effect": "Allow"
            "Action": [
                "codedeploy:CreateDeployment",
                "codedeploy:GetApplication",
                "codedeploy:GetApplicationRevision",
                "codedeploy:GetDeployment",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:RegisterApplicationRevision"
            ],
            
      },
      
      {
            "Effect": "Allow"
            "Action": [
                "ec2:*",
                "s3:*"
            ],
            "Resource": "*",
       }
    }
  }]
}
EOF
}


data "aws_kms_alias" "s3keyalias" {
  name = "alias/aws/s3keyPRODUCTION"
}






