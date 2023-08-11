variable "aws_account_id" {}
variable "aws_region" {}
variable "aws_vpc" {}

variable "company" {
  default = "slf"
}

//variable "aws_subnet" {
//  type = map(any)
//  default = {
//    az_1a = ""
//    az_1b = ""
//    az_1c = ""
//  }
//}

//variable "aws_security_group" {} 

variable "primary_owner" {
  type        = string
  description = "Name of the primary owner"
}

variable "secondary_owner" {
  type        = string
  description = "Name of the secondary owner"
}

variable "technical_contact" {
  type        = string
  description = "Name of the technical contact"
}

variable "cost_centre" {
  type        = string
  description = "Cost Centre number"
}

variable "business_unit" {
  type        = string
  description = "Name of the business unit"
}

variable "environment" {
  type        = string
  description = "sdlc environment"
}

//variable "aws-workload-role" {
//  type        = string
//  description = "Assumed role arn in aws workload account"
//}

//variable "external_id" {
//  type        = string
//  description = "Assumed external_id in aws workload account"
//}

variable "project" {}

#EC2
variable "mongodb" {
  type = map(list(any))
  default = {
    # 0 or 1, instance_type, eni-id (cannot change eni-id once ec2 is deployed), tag name, aap_stack_type, EBS1 Size, EBS2 Size
    mongodb_1 = [""]
    mongodb_2 = [""]
    mongodb_3 = [""]
  }
}

#KMS arn
variable "aws_kms_key_arn" {}


#IAM Insatnace Profile Tagging - Values


#Common Tagging
variable "ec2_tagging" {
  type = map(any)
  default = {
    tag_os_type                  = ""
    tag_os_version               = ""
    tag_application              = ""
    tag_aws_backup_plan          = ""
    tag_environment              = ""
    tag_middleware_support_group = ""
  }
}

variable "mongodb_main_security_group" {
  type = map(list(any))
  default = {
    mongodb_main_sg = [""]
  }
}

variable "mongodb_main_sg_ingress" {
  type = map(list(any))
  default = {
    port_22 = [""]
  }
}

variable "mongodb_main_sg_egress" {
  type = map(list(any))
  default = {
    port_22 = [""]
  }
}

variable "create_backup" {}
variable "restore_backup_to_ebs" {}

//variable "mongodbpwd" {
//  sensitive = true
//}
