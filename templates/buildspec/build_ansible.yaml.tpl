version: 0.2

phases:
  pre_build:
    commands:
      - yum install ansible -y
      - ansible-playbook main.yml --syntax-check
  build:
    commands:
      - zip -r ${project_name}.zip .
      - aws s3 cp ${project_name}.zip s3://${ansible_playbook_bucket_name}/${project_name}.zip
