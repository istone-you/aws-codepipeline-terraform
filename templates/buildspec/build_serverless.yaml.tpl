version: 0.2

env:
  parameter-store:
    ACCESS_KEY_ID: "ACCESS_KEY_ID"
    SECRET_ACCESS_KEY: "SECRET_ACCESS_KEY"

phases:
  pre_build:
    commands:
      - npm install serverless -g
  build:
    commands:
      - export AWS_ACCESS_KEY_ID="$${ACCESS_KEY_ID}"
      - export AWS_SECRET_ACCESS_KEY="$${SECRET_ACCESS_KEY}"
      - export AWS_DEFAULT_REGION="ap-northeast-1"
      - serverless deploy
