resource "aws_codebuild_project" "build_repo_PRODUCTION" {
  name          = "build_repo_PRODUCTION"
  description   = "PRODUCTION_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.PRODUCTIONcodebuildIAMrole.arn
  
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

 }
 artifacts {
    type = "CODEPIPELINE"
    name = "Build-Project-Webserver"
    namespace_type = "BUILD_ID"
   # location = "arn:aws:s3:::webserver-production-s3east1-bucket"
    packaging = "ZIP"
  }
  
  # artifacts {
  #   type = "S3"
  #   location = aws_s3_bucket.s3_productionEast1.bucket
  #   name = "Build-Project-Webserver"
  #   namespace_type = "BUILD_ID"
  #   packaging = "ZIP"
  #   path = "/Build-Project-Output/"
  # }

  # cache {
  #   type     = "S3"
  #   location = aws_s3_bucket.s3_productionEast1.bucket
  # }
  
  logs_config {
    cloudwatch_logs {
      group_name  = "codebuild-log-group"
      stream_name = "codebuild-log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.s3_productionEast1.id}/Project-Build-Log"
      
    }
  }
  
# logs_config {
#     cloudwatch_logs {
#       group_name  = "codebuild-log-group"
#       stream_name = "codebuild-log-stream"
#     }

#     s3_logs {
#       status   = "ENABLED"
#       location = "${aws_s3_bucket.s3_productionEast1.id}/Project-Build-Log"
      
#     }
#   }
  
  source {
    type            = "CODEPIPELINE"
    git_clone_depth = 1
    
  }
  # source {
  #   type            = "CODEPIPELINE"
  #   location        = "${aws_s3_bucket.s3_productionEast1.id}/CICDwebserver/source_out/GWG4EUo.zip"
  #   #buildspec = "${aws_s3_bucket.s3_productionEast1.id}/CICDwebserver/source_out/buildspec-files/buildspec.yml"
  #   git_clone_depth = 1
    
  #     auth {
  #       type = "OAUTH"
  #   }
  # }
}
 

  # vpc_config {
  #   security_group_ids = [ data.aws_security_group.VPC1356default.id, ]
  #   subnets = [ data.aws_subnet.subnet1356.id, ]
  #   vpc_id = data.aws_vpc.VPC1356.id
        
  # }
  


# data "aws_vpc" "VPC1356" {
#   id = "vpc-6ac80817"
# }

# data "aws_subnet" "subnet1356" {
#   id = "subnet-c616a5e7"
# }

# data "aws_security_group" "VPC1356default" {
#   id = "sg-40cc1c71"
# }


