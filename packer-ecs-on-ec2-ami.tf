module "packer_ecs_on_ec2_ami_pipeline" {
  source = "./modules/pipeline_packer"

  project_name             = "packer-ecs-on-ec2-ami"
  codecommit_repo_name     = "packer-ecs-on-ec2-ami"
  region                   = var.region
  artifacts_bucket         = aws_s3_bucket.artifacts_bucket.bucket
  artifacts_bucket_arn     = aws_s3_bucket.artifacts_bucket.arn
  artifacts_bucket_key_arn = aws_kms_key.artifacts_bucket_key.arn
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]
}
