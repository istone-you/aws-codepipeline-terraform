module "serverless_check_sakuratoaws_file_pipeline" {
  source = "./modules/pipeline_serverless"

  project_name             = "serverless-check-sakuratoaws-file"
  codecommit_repo_name     = "serverless-check-sakuratoaws-file"
  region                   = var.region
  artifacts_bucket         = aws_s3_bucket.artifacts_bucket.bucket
  artifacts_bucket_key_arn = aws_kms_key.artifacts_bucket_key.arn

  environment_variables = {
    SERVERLESS_DEPLOY_BUCKET_NAME = {
      value = var.serverless_deploy_bucket_name
    },
    BUCKET_NAME = {
      value = "fl-base"
    },
    INVOKE_TIME_INTERVAL = {
      value = "15"
    },
    OBJECT_PREFIX = {
      value = "SakuraToAws/ok/"
    }
  }
}
