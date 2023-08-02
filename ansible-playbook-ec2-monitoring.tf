module "ansible_playbook_ec2_monitoring_pipeline" {
  source = "./modules/pipeline_ansible"

  project_name                 = "ansible-playbook-ec2-monitoring"
  codecommit_repo_name         = "ansible-playbook-ec2-monitoring"
  region                       = var.region
  artifacts_bucket             = aws_s3_bucket.artifacts_bucket.bucket
  artifacts_bucket_key_arn     = aws_kms_key.artifacts_bucket_key.arn
  ansible_playbook_bucket_name = var.ansible_playbook_bucket_name
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]
}
