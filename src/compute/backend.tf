terraform {
  backend "s3" {
    # Make sure the credentials you're using can access this bucket!
    bucket = "rpost-vish-splunk-tfstate"
    key    = "compute/terraform.tfstate"
    region = "us-east-2"
    acl    = "bucket-owner-full-control"
  }
}