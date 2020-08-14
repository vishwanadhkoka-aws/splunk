resource "aws_instance" "appserver" {  
  ami            = "${data.aws_ami.rhel8.id}"
  instance_type = var.appserver["instancetype"]
  subnet_id     = data.aws_subnet.priv[0].id
  key_name      = var.key_name

  #vpc_security_group_ids  = ["sg-0d27a8b3722e7954a","sg-0b8988c9be72cdf39"]
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  vpc_security_group_ids  = [module.default_sgs.sg_id_linux,"sg-040d45cc8a5fbfdb7"]

  tags = merge(
    var.tags,
    {
      "Name" = "${var.tags["SourceMarket"]}-${var.tags["Environment"]}-ec2-${var.tags["Application"]}-${var.appserver["hostname"]}"
    },
  )

  connection {
    host    = coalesce(self.public_ip, self.private_ip)
    type    = "ssh"
    agent   = true
    user    = "ec2-user"
    timeout = "5m"
  }

  provisioner "file" {
    source      = "../../../cmap-mf-ansible-serversetup/bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "file" {
    source      = "/var/tmp/timaint"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [   
      "/usr/bin/sudo mkdir /opt/tui",
      "/usr/bin/sudo mv /tmp/timaint /opt/tui"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "/usr/bin/sudo /tmp/bootstrap.sh ${var.appserver["hostname"]} ${var.tuiad_domain_join_password}",
    ]
  }

  # Changes related to ansible
  # set python3 as default
  # renamed python-lxml to python3-lxml
  # shell: "/opt/tui/cmk/usr/lib/check_mk_agent/plugins/*/cmk-update-agent" 
  # Changed to 
  # shell: "python2 /opt/tui/cmk/usr/lib/check_mk_agent/plugins/*/cmk-update-agent" 

  provisioner "local-exec" {
    command = "ansible-playbook ../../../cmap-mf-ansible-serversetup/bmcscan-install.yml --extra-vars='{\"hostname\":\"${aws_instance.appserver.private_ip}\",\"CMDB_CIID\":\"${var.appserver["ciid"]}\"}'"
    on_failure = "continue"
  }

  provisioner "local-exec" {
    command = "ansible-playbook ../../../cmap-mf-ansible-serversetup/lx_av.yml --extra-vars '{\"hostname\":\"${aws_instance.appserver.private_ip}\"}'"
    on_failure = "continue"
  }

  provisioner "local-exec" {
    command = "ansible-playbook ../../../cmap-mf-ansible-serversetup/cmk-agent-install.yml --extra-vars '{\"hostname\":\"${aws_instance.appserver.private_ip}\"}'"
    on_failure = "continue"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum history sync",
    ]
  }
  /*depends_on = [
    "aws_ami_copy.rhel7_encrypted",
  ]*/
}