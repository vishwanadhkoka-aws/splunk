resource "aws_kms_key" "ebs" {}

resource "aws_kms_alias" "ebs" {
  name          = "alias/${var.tags["SourceMarket"]}-${var.tags["Environment"]}-kms-${var.tags["Application"]}-ebs"
  target_key_id = aws_kms_key.ebs.key_id
}