provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn     = "arn:aws:iam::${var.aws_account_number}:role/${var.aws_deployment_role}"
    session_name = "app_env_deployment@${var.aws_account_number}"
  }
}

