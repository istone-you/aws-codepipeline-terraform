module "docker_monitoring_opentelemetry_pipeline" {
  source = "./modules/pipeline_docker"

  project_name             = "docker-monitoring-opentelemetry"
  codecommit_repo_name     = "docker-monitoring-opentelemetry"
  ecr_repo_name            = "monitoring-opentelemetry"
  deploy_script            = "echo 'Docker push successful! Image uploaded to the repository.'"
  region                   = var.region
  artifacts_bucket         = var.artifacts_bucket_name
  artifacts_bucket_key_arn = var.artifacts_bucket_key_arn
  docker_sercrets_arn      = var.docker_sercrets_arn
}


