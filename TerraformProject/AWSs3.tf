#AWS S3 Bucket to Store Artifacts from CodePipeline
resource "aws_s3_bucket" "s3_productionEast1" {
  bucket = "webserver-production-s3east1-bucket"
  force_destroy = true
  
  grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
  
  versioning {
    enabled = true
  }
}

data "aws_canonical_user_id" "current_user" {}

#AWS Bucket Policy to Permit S3 Bucket Access to CodePipeline 
resource "aws_s3_bucket_policy" "s3_productionEast1_policy" {
  bucket = aws_s3_bucket.s3_productionEast1.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codepipeline.amazonaws.com"
            },
            "Action": [
            "s3:ListBucket",
            "s3:Put*"
            ],
            "Resource": [
              "${aws_s3_bucket.s3_productionEast1.arn}",
              "${aws_s3_bucket.s3_productionEast1.arn}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": [
            "s3:Get*",
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
              "${aws_s3_bucket.s3_productionEast1.arn}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": [ 
            "s3:Put*",
            "s3:List*"
            ],
            "Resource": [
              "${aws_s3_bucket.s3_productionEast1.arn}",
              "${aws_s3_bucket.s3_productionEast1.arn}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codedeploy.amazonaws.com"
            },
            "Action": [
            "s3:List*",
            "s3:Put*",
            "s3:Get*"
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

#AWS Generated Encryption Key for CodePipeline Artifact Store Bucket
resource "aws_kms_key" "s3_bucket_kms_key1" {
  description             = "KMS key1 for Codepipeline"
  is_enabled = true
  key_usage = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 7
}

    #AWS S3 Bucket Encryption Key Alias to be Referenced by CodePipeline
    resource "aws_kms_alias" "s3_bucket_kms_key1_alias" {
      name          = "alias/Codepipeline-key1"
      target_key_id = aws_kms_key.s3_bucket_kms_key1.key_id
    }

       