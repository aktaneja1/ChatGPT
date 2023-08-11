locals {
  common_tags = {
    Environment = var.environment
    Account     = data.aws_caller_identity.current.account_id
  }
}

data "aws_caller_identity" "current" {}


