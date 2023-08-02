
resource "aws_codepipeline" "file_pipeline" {
  name     = "${var.project_name}-pipeline"
  role_arn = aws_iam_role.pipeline_role.arn

  artifact_store {
    location = var.artifacts_bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]
      configuration = {
        RepositoryName       = var.codecommit_repo_name
        BranchName           = "master"
        PollForSourceChanges = false
      }
      region    = var.region
      namespace = "SourceVariables"
      run_order = 1
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      version         = "1"
      input_artifacts = ["SourceArtifact"]
      configuration = {
        BucketName = var.bucket_name
        Extract    = var.extract
        ObjectKey  = var.object_key
      }
      region    = var.region
      namespace = "Deploy"
      run_order = 1
    }
  }
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  name = "${var.project_name}-rule"

  event_pattern = templatefile("./templates/event_pattern/event_pattern.json.tpl", {
    codecommit_arn : "arn:aws:codecommit:ap-northeast-1:${data.aws_caller_identity.current.account_id}:${var.codecommit_repo_name}"
  })
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule     = aws_cloudwatch_event_rule.event_rule.name
  arn      = aws_codepipeline.file_pipeline.arn
  role_arn = aws_iam_role.event_role.arn
}

resource "aws_iam_role" "pipeline_role" {
  name = "${var.project_name}-pipeline-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "codepipline_policy"

    policy = templatefile(
      "./templates/iam_policy/policy_pipeline_file.json.tpl", {
        aws_account_id       = data.aws_caller_identity.current.account_id
        bucket_name          = var.bucket_name
        artifacts_bucket     = var.artifacts_bucket
        codecommit_repo_name = var.codecommit_repo_name
    })
  }

  tags = {
    Name = "${var.project_name}-pipeline-role"
  }
}

resource "aws_iam_role" "event_role" {
  name = "${var.project_name}-event-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"]
}
