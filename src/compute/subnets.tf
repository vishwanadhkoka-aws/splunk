data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnet_ids" "subnet_all" {
  vpc_id = var.vpc_id
}

data "aws_subnet" "priv" {
  vpc_id = var.vpc_id

  count = "2"

  filter {
    name   = "tag:Name"
    values = ["cmap-mrp-dc-haj-app-${count.index}"]
  }
}

data "aws_subnet" "pub" {
  vpc_id = var.vpc_id

  count = "2"

  filter {
    name   = "tag:Name"
    values = ["cmap-mrp-dc-haj-pub-${count.index}"]
  }
}

