
resource "aws_codebuild_project" "terraform_build" {
  name          = "${var.codecommit_repo_name}-build"
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
  encryption_key = aws_kms_key.artifacts_bucket_key.arn

  tags = {
    Name = "${var.codecommit_repo_name}-build"
  }
}


resource "aws_codepipeline" "codebuild_terraform_pipeline" {
  name     = "${var.codecommit_repo_name}-pipeline"
  role_arn = aws_iam_role.pipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.artifacts_bucket.bucket
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
        ProjectName = "${var.codecommit_repo_name}-build"
      }
      region    = var.region
      namespace = "Build"
      run_order = 1
    }
  }
}

resource "aws_iam_role" "build_role" {
  name = "${var.codecommit_repo_name}-build-role"
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
    Name = "${var.codecommit_repo_name}-build-role"
  }
}

resource "aws_iam_role" "pipeline_role" {
  name = "${var.codecommit_repo_name}-pipeline-role"
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
        artifacts_bucket     = aws_s3_bucket.artifacts_bucket.bucket
        build_project_arn    = aws_codebuild_project.terraform_build.arn
        codecommit_repo_name = var.codecommit_repo_name
    })
  }

  tags = {
    Name = "${var.codecommit_repo_name}-pipeline-role"
  }
}
