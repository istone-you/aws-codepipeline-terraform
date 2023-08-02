module "file_windows_monitoring_pipeline" {
  source = "./modules/pipeline_file"

  project_name                 = "file-windows-monitoring"
  codecommit_repo_name         = "file-windows-monitoring"
  bucket_name                  = var.file_deploy_bucket_name
  extract                      = false
  object_key                   = "file-windows-monitoring.zip"
  region                       = var.region
  artifacts_bucket             = var.artifacts_bucket_name
  artifacts_bucket_key_arn     = var.artifacts_bucket_key_arn
  ansible_playbook_bucket_name = var.ansible_playbook_bucket_name
}
