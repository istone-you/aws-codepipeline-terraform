{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:logs:ap-northeast-1:${aws_account_id}:log-group:/aws/codebuild/${build_project_name}",
        "arn:aws:logs:ap-northeast-1:${aws_account_id}:log-group:/aws/codebuild/${build_project_name}:*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${artifacts_bucket}/*",
        "arn:aws:s3:::${ansible_playbook_bucket_name}/*"
      ],
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketAcl",
        "s3:GetBucketLocation"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:UpdateReport",
        "codebuild:BatchPutTestCases",
        "codebuild:BatchPutCodeCoverages"
      ],
      "Resource": [
        "arn:aws:codebuild:ap-northeast-1:${aws_account_id}:report-group/${build_project_name}-*"
      ]
    }
  ]
}
