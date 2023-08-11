variable "aws_account_id" {}
variable "aws_region" {}
variable "ami" {}
variable "ec2_tagging" {}
variable "aws_subnet" {}
variable "aws_security_group" {}
variable "aws_kms_key_arn" {}
variable "mongodb" {}
variable "network_interface" {}
variable "network_interface_pri" {} 
variable "network_interface_sec1" {} 
variable "network_interface_sec2" {} 

variable "availability_zone" {}
variable "snapshot_id" {}

variable "create_backup" {}
variable "restore_backup_to_ebs" {}