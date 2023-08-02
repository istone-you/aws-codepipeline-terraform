module "ansible_playbook_ec2_monitoring_pipeline" {
  source = "./modules/pipeline_ansible"

  project_name                 = "ansible-playbook-ec2-monitoring"
  codecommit_repo_name         = "ansible-playbook-ec2-monitoring"
  region                       = var.region
  artifacts_bucket             = var.artifacts_bucket_name
  artifacts_bucket_key_arn     = var.artifacts_bucket_key_arn
  ansible_playbook_bucket_name = var.ansible_playbook_bucket_name
}
