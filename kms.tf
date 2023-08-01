resource "aws_kms_key" "artifacts_bucket_key" {
  description = "pipeline artifact Key"
  is_enabled  = true
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
  key_usage = "ENCRYPT_DECRYPT"
  tags = {
    Name = "s3-artifact-key"
  }
}

resource "aws_kms_alias" "key_alias_artifacts_bucket" {
  name          = "alias/s3-artifact-key"
  target_key_id = aws_kms_key.artifacts_bucket_key.key_id
}
