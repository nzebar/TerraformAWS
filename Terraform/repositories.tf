resource "aws_codecommit_repository" "repo1356" { //Calls resource module to create a repository.
  repository_name = "repo_TESTING" //Names of the repository
  description     = "This repository will consist of the code for the testing server." //description of repo
}

resource "aws_codecommit_repository" "repo2356" { //Calls resource module to create a repository.
  repository_name = "repo_PRODUCTION" //Names of the repository
  description     = "This repository will consist of the code for the production server." //description of repo
}