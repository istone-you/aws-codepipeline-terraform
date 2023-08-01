version: 0.2

env:
  secrets-manager:
    DOCKERHUB_USER: ${docker_sercrets_arn}:username
    DOCKERHUB_PASS: ${docker_sercrets_arn}:password

phases:
  pre_build:
    commands:
    - echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
  build:
    commands:
      - docker build -t ${ecr_repo_name} .
  post_build:
    commands:
      - docker tag ${ecr_repo_name}:latest ${aws_account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${ecr_repo_name}:latest
      - aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.ap-northeast-1.amazonaws.com
      - docker push ${aws_account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${ecr_repo_name}:latest
      - ${deploy_script}
