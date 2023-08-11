locals {
  common_tags = {
    Environment = var.environment
    Account     = data.aws_caller_identity.current.account_id
  }
}

data "aws_caller_identity" "current" {}

/*
module "mongodb_sg" {
  source = "./modules/networks"

  vpc_id            = var.aws_vpc
  sg_name           = var.mongodb_main_security_group.mongodb_main_sg
  sg_ingress        = var.mongodb_main_sg_ingress
  sg_egress         = var.mongodb_main_sg_egress
}*/

module "mongodb_eni_1a" {
  source             = "./modules/eni"
  mongodb            = var.mongodb.mongodb_1
  ec2_tagging        = var.ec2_tagging
  aws_subnet         = data.aws_subnet.subnet_priv_a1.id
  aws_security_group = data.aws_security_group.vpc_security_groups.id
}

module "mongodb_eni_1b" {
  source             = "./modules/eni"
  mongodb            = var.mongodb.mongodb_2
  ec2_tagging        = var.ec2_tagging
  aws_subnet         = data.aws_subnet.subnet_priv_b1.id
  aws_security_group = data.aws_security_group.vpc_security_groups.id
}

module "mongodb_eni_1c" {
  source             = "./modules/eni"
  mongodb            = var.mongodb.mongodb_3
  ec2_tagging        = var.ec2_tagging
  aws_subnet         = data.aws_subnet.subnet_priv_c1.id
  aws_security_group = data.aws_security_group.vpc_security_groups.id
}

module "mongodb_1a" {
  source = "./modules/primary_mongodb"

  aws_account_id         = var.aws_account_id
  aws_region             = var.aws_region
  ami                    = data.aws_ami.application_image.id
  ec2_tagging            = var.ec2_tagging
  aws_subnet             = data.aws_subnet.subnet_priv_a1.id              //var.aws_subnet
  aws_security_group     = data.aws_security_group.vpc_security_groups.id //var.aws_security_group
  aws_kms_key_arn        = var.aws_kms_key_arn
  mongodb                = var.mongodb.mongodb_1
  network_interface      = module.mongodb_eni_1a.mongodb_eni.id
  network_interface_pri  = module.mongodb_eni_1a.mongodb_eni.private_ip
  network_interface_sec1 = module.mongodb_eni_1b.mongodb_eni.private_ip
  network_interface_sec2 = module.mongodb_eni_1c.mongodb_eni.private_ip

  availability_zone = data.aws_subnet.subnet_priv_a1.availability_zone
  snapshot_id       = data.aws_ebs_snapshot.mongodbVol.id

  create_backup         = var.create_backup
  restore_backup_to_ebs = var.restore_backup_to_ebs
}

module "mongodb_1b" {
  source = "./modules/secondary_mongodb"

  aws_account_id         = var.aws_account_id
  aws_region             = var.aws_region
  ami                    = data.aws_ami.application_image.id
  ec2_tagging            = var.ec2_tagging
  aws_subnet             = data.aws_subnet.subnet_priv_b1.id              //var.aws_subnet
  aws_security_group     = data.aws_security_group.vpc_security_groups.id //var.aws_security_group
  aws_kms_key_arn        = var.aws_kms_key_arn
  mongodb                = var.mongodb.mongodb_2
  network_interface      = module.mongodb_eni_1b.mongodb_eni.id
  network_interface_pri  = module.mongodb_eni_1a.mongodb_eni.private_ip
  network_interface_sec1 = module.mongodb_eni_1b.mongodb_eni.private_ip
  network_interface_sec2 = module.mongodb_eni_1c.mongodb_eni.private_ip
}

module "mongodb_1c" {
  source = "./modules/secondary_mongodb"

  aws_account_id         = var.aws_account_id
  aws_region             = var.aws_region
  ami                    = data.aws_ami.application_image.id
  ec2_tagging            = var.ec2_tagging
  aws_subnet             = data.aws_subnet.subnet_priv_c1.id              //var.aws_subnet
  aws_security_group     = data.aws_security_group.vpc_security_groups.id //var.aws_security_group
  aws_kms_key_arn        = var.aws_kms_key_arn
  mongodb                = var.mongodb.mongodb_3
  network_interface      = module.mongodb_eni_1c.mongodb_eni.id
  network_interface_pri  = module.mongodb_eni_1a.mongodb_eni.private_ip
  network_interface_sec1 = module.mongodb_eni_1b.mongodb_eni.private_ip
  network_interface_sec2 = module.mongodb_eni_1c.mongodb_eni.private_ip
}
