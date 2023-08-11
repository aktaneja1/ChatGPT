locals {
  tag_set = {
    Name                     = var.mongodb[4]
    os_type                  = var.ec2_tagging.tag_os_type
    os_version               = var.ec2_tagging.tag_os_version
    application              = var.ec2_tagging.tag_application
    aws_backup_plan          = var.ec2_tagging.tag_aws_backup_plan
    environment              = var.ec2_tagging.tag_environment
    middleware_support_group = var.ec2_tagging.tag_middleware_support_group
  }
}

resource "aws_network_interface" "eni" {
    subnet_id       = var.aws_subnet
    security_groups = [var.aws_security_group]
    tags            = local.tag_set
}