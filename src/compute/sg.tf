module "default_sgs" {
  source = "git::ssh://git@ssh.git.mf.tuigroup.com/imsd/consulting-services/cloudspecialists/imsd-cs-tf-module-default-sgs.git?ref=v4.0.0"

  vpc_id = var.vpc_id
  tags   = var.tags
}