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
        "${artifacts_bucket_arn}",
        "${artifacts_bucket_arn}/*"
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
      "Resource": "${artifacts_bucket_arn}"
    },
    {
      "Sid": "CodeBuildProjects",
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild",
        "codebuild:StopBuild"
      ],
      "Resource": [
        "${build_project_arn}"
      ]
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
