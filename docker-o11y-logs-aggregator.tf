module "docker_o11y_logs_aggregator_pipeline" {
  source = "./modules/pipeline_docker"

  project_name             = "docker-o11y-logs-aggregator"
  codecommit_repo_name     = "docker-o11y-logs-aggregator"
  ecr_repo_name            = "o11y-logs-aggregator"
  deploy_script            = "aws ecs update-service --force-new-deployment --cluster o11y-aggregator --service logs-aggregator"
  region                   = var.region
  artifacts_bucket         = var.artifacts_bucket_name
  artifacts_bucket_key_arn = var.artifacts_bucket_key_arn
  docker_sercrets_arn      = var.docker_sercrets_arn
}


