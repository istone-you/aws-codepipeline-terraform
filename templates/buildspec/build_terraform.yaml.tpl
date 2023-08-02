version: 0.2

env:
  parameter-store:
    ACCESS_KEY_ID: "ACCESS_KEY_ID"
    SECRET_ACCESS_KEY: "SECRET_ACCESS_KEY"

phases:
  install:
    commands:
      - export AWS_ACCESS_KEY_ID="$${ACCESS_KEY_ID}"
      - export AWS_SECRET_ACCESS_KEY="$${SECRET_ACCESS_KEY}"
      - export AWS_DEFAULT_REGION="ap-northeast-1"
  pre_build:
    commands:
      - "terraform init -input=false -no-color"
      - "terraform plan -input=false -no-color"
  build:
    commands:
      - "terraform apply -input=false -no-color -auto-approve"
