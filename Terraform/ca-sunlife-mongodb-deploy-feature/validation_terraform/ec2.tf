locals {
  tag_set = {
    Name                     = var.mongodb.mongodb_1[4]
    os_type                  = var.ec2_tagging.tag_os_type
    os_version               = var.ec2_tagging.tag_os_version
    application              = var.ec2_tagging.tag_application
    aws_backup_plan          = var.ec2_tagging.tag_aws_backup_plan
    environment              = var.ec2_tagging.tag_environment
    middleware_support_group = var.ec2_tagging.tag_middleware_support_group
  }
}
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.application_image.id
  instance_type          = var.mongodb.mongodb_1[1]
  subnet_id              = data.aws_subnet.subnet_priv_a1.id
  vpc_security_group_ids = [data.aws_security_group.vpc_security_groups.id]
  tags                   = local.tag_set
} 