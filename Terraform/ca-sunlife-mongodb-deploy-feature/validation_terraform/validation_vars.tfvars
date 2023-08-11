#AEP Environment
environment    = "NONPROD"
aws_account_id = "714608869743"
aws_region     = "ca-central-1"
aws_vpc        = "vpc-0f47cc0137cab92b0"

mongodb = {
  # 0 or 1, instance_type, eni-id (cannot change eni-id once ec2 is deployed), tag name, aap_stack_type, EBS1 Size, EBS2 Size
  mongodb_1 = [0, "t2.large", "", "cl0a0001", "mongodb_1", 0, 0]
  mongodb_2 = [0, "t2.large", "", "cl0a0002", "mongodb_2", 0, 0]
  mongodb_3 = [0, "t2.large", "", "cl0a0003", "mongodb-3", 0, 0]
}

aws_kms_key_arn = "arn:aws:kms:ca-central-1:714608869743:key/4eeb152a-ccef-4750-8269-74566b4b3a75"

ec2_tagging = {
  tag_os_type                  = "redhat-mongodb"
  tag_os_version               = "8.7"
  tag_application              = "Test Application"
  tag_aws_backup_plan          = "none"
  tag_environment              = "Development"
  tag_middleware_support_group = "CI Tools"
}

#Default_Tagging
primary_owner     = "Saman Aghamir-Baha"
secondary_owner   = "Vikas Choata"
technical_contact = "Saman Aghamir-Baha"
cost_centre       = "183485"
business_unit     = "DevOps"
project           = "Automated Environment Provisioning (AEP)"

