module "docker_o11y_yace_exporter_pipeline" {
  source = "./modules/pipeline_docker"

  project_name             = "docker-o11y-yace-exporter"
  codecommit_repo_name     = "docker-o11y-yace-exporter"
  ecr_repo_name            = "o11y-yace-exporter"
  deploy_script            = "aws ecs update-service --force-new-deployment --cluster o11y-aggregator --service yace-exporter"
  region                   = var.region
  artifacts_bucket         = aws_s3_bucket.artifacts_bucket.bucket
  artifacts_bucket_key_arn = aws_kms_key.artifacts_bucket_key.arn
  docker_sercrets_arn      = var.docker_sercrets_arn
}


