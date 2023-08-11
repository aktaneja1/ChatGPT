#NEW TERRAFORM
terraform {
  required_version = "> 1.1.3"

  // cloud {
  //   organization = "slf-prod"
  //   workspaces {
  //     name = "enterprise_aep-dev"
  //   }
  // }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.21"
    }
    # Added local provider
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }
}
# Configure the Local Provider
provider "local" {
  # Configuration options
}

# Configure the AWS Provider
provider "aws" {
  default_tags {
    tags = {
      Primary_Owner     = var.primary_owner
      Secondary_Owner   = var.secondary_owner
      Technical_Contact = var.technical_contact
      Cost_Centre       = var.cost_centre
      Business_Unit     = var.business_unit
      Company           = var.company
      Project           = var.project
      Author            = "terraform"
    }
  }
  region = var.aws_region
  //  assume_role {
  //    role_arn    = var.aws-workload-role
  //    external_id = var.external_id
  //  }
}
