
resource "aws_codebuild_project" "terraform_build" {
  name          = "${var.project_name}-build"
  service_role  = aws_iam_role.build_role.arn
  build_timeout = 60

  source {
    type      = "CODEPIPELINE"
    buildspec = templatefile("./templates/buildspec/build_terraform.yaml.tpl", {})
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    type                        = "LINUX_CONTAINER"
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:latest"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }
  encryption_key = var.artifacts_bucket_key_arn

  tags = {
    Name = "${var.project_name}-build"
  }
}


resource "aws_codepipeline" "terraform_pipeline" {
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
    name = "Build"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["SourceArtifact"]
      configuration = {
        ProjectName = "${var.project_name}-build"
      }
      region    = var.region
      namespace = "Build"
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
  arn      = aws_codepipeline.terraform_pipeline.arn
  role_arn = aws_iam_role.event_role.arn
}

resource "aws_iam_role" "build_role" {
  name = "${var.project_name}-build-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"

        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })

  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]

  tags = {
    Name = "${var.project_name}-build-role"
  }
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
      "./templates/iam_policy/policy_pipeline.json.tpl", {
        aws_account_id       = data.aws_caller_identity.current.account_id
        artifacts_bucket     = var.artifacts_bucket
        build_project_arn    = aws_codebuild_project.terraform_build.arn
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
