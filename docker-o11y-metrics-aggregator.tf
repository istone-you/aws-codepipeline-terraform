module "docker_o11y_metrics_aggregator_pipeline" {
  source = "./modules/pipeline_docker"

  project_name             = "docker-o11y-metrics-aggregator"
  codecommit_repo_name     = "docker-o11y-metrics-aggregator"
  ecr_repo_name            = "o11y-metrics-aggregator"
  deploy_script            = "aws ecs update-service --force-new-deployment --cluster o11y-aggregator --service metrics-aggregator"
  region                   = var.region
  artifacts_bucket         = var.artifacts_bucket_name
  artifacts_bucket_key_arn = var.artifacts_bucket_key_arn
  docker_sercrets_arn      = var.docker_sercrets_arn
}


