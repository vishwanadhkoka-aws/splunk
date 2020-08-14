variable "aws_region" {
  description = "The region for the application evnironment - Default is Frankfurt as our main region"
  default     = "us-east-2"
}

variable "aws_account_number" {
  description = "The account number used for the environment"
}

variable "aws_deployment_role" {
  description = "The IAM role that is used for terraform to deploy the infrastructure"
}

variable "tags" {
  description = "Common tags shared across all resources, specific tags are in the resources"

  default = {
    BusinessUnit   = "Migration Factory"
    Tier           = "normal"
    Classification = "normal"
    SourceMarket   = "tuid"
    Application    = "rpost-splunk"
    backup         = "rrhel8"
  }
}

variable "vpc_id" {
  description = "VPC ID"
}

 
}

variable "key_name" {
  description = "The key name to use for the instance"
}

variable "kms_key_id" {
  description = "The encrypted key arn to use for the instance"
}

variable "appserver" {
  description = "Holds information about the app server"

  default = {
    hostname     = ""
    ciid         = ""
    instancetype = ""
  }
}

