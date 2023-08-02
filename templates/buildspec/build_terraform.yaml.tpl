version: 0.2

env:
  parameter-store:
    ACCESS_KEY_ID: "ACCESS_KEY_ID"
    SECRET_ACCESS_KEY: "SECRET_ACCESS_KEY"
    TERRAFORM_CLOUD_TOKEN: "TERRAFORM_CLOUD_TOKEN"

phases:
  install:
    commands:
      - echo "{\"credentials\":{\"app.terraform.io\":{\"token\":\"$${TERRAFORM_CLOUD_TOKEN}\"}}}" >> $HOME/.terraformrc
      - echo "access_key = \"$${ACCESS_KEY_ID}\"" >> terraform.tfvars
      - echo "secret_key = \"$${SECRET_ACCESS_KEY}\"" >> terraform.tfvars
  pre_build:
    commands:
      - "terraform init -input=false -no-color"
  build:
    commands:
      - "terraform apply -input=false -no-color -auto-approve"
