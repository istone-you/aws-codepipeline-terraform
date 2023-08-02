module "packer_ecs_on_ec2_ami_pipeline" {
  source = "./modules/pipeline_packer"

  project_name             = "packer-ecs-on-ec2-ami"
  codecommit_repo_name     = "packer-ecs-on-ec2-ami"
  region                   = var.region
  artifacts_bucket         = var.artifacts_bucket_name
  artifacts_bucket_key_arn = var.artifacts_bucket_key_arn
}
