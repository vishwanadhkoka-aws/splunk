data "aws_ami" "rhel8" {
  most_recent = true

  owners = ["880013969777 "]

  filter {
    name   = "name"
    values = ["RHEL-8*HVM-*-x86_64*GP2"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}