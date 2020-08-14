aws_account_number = "880013969777"
aws_deployment_role = "rpost-dev-gitlab-deployment-role"
tags = {
  "TechnicalOwner" = ""
  "Application"    = ""
  "Environment"    = "dev"
  "BusinessUnit"   = "cs"
  "SourceMarket"   = "imsd"
  "backup"         = "rp_rhel8"
}
vpc_id = "vpc-0669823860e78b658"
key_name = "mf-pipeline"
appserver = {
  "hostname"     = ""  # defra1sv00255
  "ciid"         = ""
  "instancetype" = "t3.medium"
}
kms_key_id = "arn:aws:kms:us-east-2:880013969777:key/8bcf0f6b-144f-4ab7-9f18-c5c2893898f7"