terraform {
  cloud {
    organization = "flogic"

    workspaces {
      name = "aws-codepipeline-prod"
    }
  }
}
