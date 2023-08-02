module "docker_o11y_otel_4_yace_pipeline" {
  source = "./modules/pipeline_docker"

  project_name             = "docker-o11y-otel-4-yace"
  codecommit_repo_name     = "docker-o11y-otel-4-yace"
  ecr_repo_name            = "o11y-otel-4-yace"
  deploy_script            = "aws ecs update-service --force-new-deployment --cluster o11y-aggregator --service yace-exporter"
  region                   = var.region
  artifacts_bucket         = var.artifacts_bucket_name
  artifacts_bucket_key_arn = var.artifacts_bucket_key_arn
  docker_sercrets_arn      = var.docker_sercrets_arn
}


