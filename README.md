# CodePipeline 用の Terraform

## Variables

Terraform Cloud の Variables に下記変数を指定してください。

- access_key = AWS のアクセスキー
- secret_key = AWS のシークレットキー
- region = AWS のリージョン
- docker_sercrets_arn = Docker Hub のアカウント情報が記載された Secrets Manager の Arn
- ansible_playbook_bucket_name = Ansible Playbook を格納する S3 バケット

## Modules

### pipeline_ansible

CodeCommit リポジトリへのプッシュをトリガーに Ansible Playbook の Zip ファイル S3 に作成する CodePipeline を作成するモジュールです。下記値を指定してください。

- project_name = プロジェクト名
- codecommit_repo_name = Ansible Playbook をプッシュしている CodeCommit のレポジトリ名
- managed_policy_arns = CodeBuild に付与するマネージドポリシー

### pipeline_docker

CodeCommit リポジトリへのプッシュをトリガーに Pakcer を実行する CodePipeline を作成するモジュールです。下記値を指定してください。

- project_name = プロジェクト名
- codecommit_repo_name = Packer の実行ファイルをプッシュしている CodeCommit のレポジトリ名
- ecr_repo_name = ECR のレポジトリ名
- deploy_script = デプロイ時のスクリプト<br><br>
  例）ECS のタスクを置き換えたい場合は下記

  ```sh
  aws ecs update-service --force-new-deployment --cluster <クラスター名> --service <サービス名>
  ```

  プッシュするだけなら Echo コマンド等を指定してください。

  ```sh
  echo 'Docker push successful! Image uploaded to the repository.'
  ```

- managed_policy_arns = CodeBuild に付与するマネージドポリシー

### pipeline_packer

CodeCommit リポジトリへのプッシュをトリガーに Docker イメージを作成し、そのイメージを ECR にプッシュする odePipeline を作成するモジュールです。下記値を指定してください。

- project_name = プロジェクト名
- codecommit_repo_name = CodeCommit のレポジトリ名
- managed_policy_arns = CodeBuild に付与するマネージドポリシー
