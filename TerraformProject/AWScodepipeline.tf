resource "aws_codepipeline" "Production_Pipeline" {
  name     = "CICDwebserver"
  role_arn = aws_iam_role.codepipeline_role_webserver_production.arn
  

  artifact_store {
    location = aws_s3_bucket.s3_productionEast1.id
    type     = "S3"
    
    encryption_key {
      id   = aws_kms_alias.s3_bucket_kms_key1_alias.arn
      type = "KMS"
    }
  }
  
  stage {
    name = "CodeCommit"
    
    action {
      name             = "CodeCommit_Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]
      
      configuration = {
        RepositoryName = aws_codecommit_repository.Developers-Testing-Production-Repository.repository_name
        BranchName = "master"
        PollForSourceChanges = "True"
      }
    }

    # action {
    #   name             = "GitHub_Source"
    #   category         = "Source"
    #   owner            = "ThirdParty"
    #   provider         = "GitHub"
    #   version          = "1"
    #   output_artifacts = ["source_output"]
      
    #   configuration = {
    #     OAuthToken = "44b06c41373f2007784de6ba5254a34ba51d3907"
    #     Owner  = "nzebar"
    #     Repo   = github_repository.CICDrepository.name
    #     Branch = "main"
    #   }
    # }
    
  }
  
  stage {
    name = "CodeBuild"

    action {
      name            = "CodeBuild"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source_output"]
      output_artifacts = ["Build-Project-Webserver"]
      version         = "1"
    

      configuration = {
        ProjectName = aws_codebuild_project.build_repo_PRODUCTION.name
      }
    }
  }
  
   stage {
    name = "CodeDeploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["Build-Project-Webserver"]
      version         = "1"
    
      
      configuration = {
        ApplicationName = aws_codedeploy_app.appPRODUCTION.name
        DeploymentGroupName = aws_codedeploy_deployment_group.deploymentgroupPRODUCTION.deployment_group_name
        }

      }
    }
  }



