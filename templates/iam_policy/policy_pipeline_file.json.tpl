{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3Artifact",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject*",
        "s3:GetBucket*",
        "s3:List*",
        "s3:DeleteObject*",
        "s3:PutObject",
        "s3:Abort*"
      ],
      "Resource": [
        "arn:aws:s3:::${bucket_name}",
        "arn:aws:s3:::${bucket_name}/*",
        "arn:aws:s3:::${artifacts_bucket}",
        "arn:aws:s3:::${artifacts_bucket}/*"
      ]
    },
    {
      "Sid": "KmsKey",
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey",
        "kms:Encrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*"
      ],
      "Resource": "arn:aws:s3:::${artifacts_bucket}"
    },
    {
      "Sid": "CodeCommit",
      "Effect": "Allow",
      "Action": [
        "codecommit:CancelUploadArchive",
        "codecommit:GetBranch",
        "codecommit:GetCommit",
        "codecommit:GetRepository",
        "codecommit:GetUploadArchiveStatus",
        "codecommit:UploadArchive"
      ],
      "Resource": "arn:aws:codecommit:ap-northeast-1:${aws_account_id}:${codecommit_repo_name}"
    }
  ]
}
