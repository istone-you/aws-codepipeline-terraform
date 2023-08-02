terraform {
  cloud {
    organization = "flogic"

    workspaces {
      name = "aws-tfpipeline-prod"
    }
  }
}
