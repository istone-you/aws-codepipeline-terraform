version: 0.2

env:
  parameter-store:
    ACCESS_KEY_ID: "ACCESS_KEY_ID"
    SECRET_ACCESS_KEY: "SECRET_ACCESS_KEY"

phases:
  pre_build:
    commands:
      - curl -qL -o packer.zip https://releases.hashicorp.com/packer/1.8.6/packer_1.8.6_linux_amd64.zip && unzip packer.zip
      - yum install ansible -y
      - ./packer validate .
  build:
    commands:
      - export AWS_ACCESS_KEY_ID="$${ACCESS_KEY_ID}"
      - export AWS_SECRET_ACCESS_KEY="$${SECRET_ACCESS_KEY}"
      - export AWS_DEFAULT_REGION="ap-northeast-1"
      - ./packer build .
