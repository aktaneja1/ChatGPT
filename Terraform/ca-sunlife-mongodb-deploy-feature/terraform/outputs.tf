output "mongodb1_private_dns" {
  value = module.mongodb_1a.private_dns
}

output "mongodb1_private_ip" {
  value = module.mongodb_1a.private_ip
}

output "mongodb1_ec2_arn" {
  value = module.mongodb_1a.ec2_arn
}

output "mongodb1_all_tags" {
  value = module.mongodb_1a.all_tags
}

output "mongodb2_private_dns" {
  value = module.mongodb_1b.private_dns
}

output "mongodb2_private_ip" {
  value = module.mongodb_1b.private_ip
}

output "mongodb2_ec2_arn" {
  value = module.mongodb_1b.ec2_arn
}

output "mongodb2_all_tags" {
  value = module.mongodb_1b.all_tags
}

output "mongodb3_private_dns" {
  value = module.mongodb_1c.private_dns
}

output "mongodb3_private_ip" {
  value = module.mongodb_1c.private_ip
}

output "mongodb3_ec2_arn" {
  value = module.mongodb_1c.ec2_arn
}

output "mongodb3_all_tags" {
  value = module.mongodb_1c.all_tags
}

output "primary_mongodb" {
  value = module.mongodb_eni_1a.mongodb_eni.private_ip
}

output "secondary_mongodb-1b" {
  value = module.mongodb_eni_1b.mongodb_eni.private_ip
}

output "secondary_mongodb-1c" {
  value = module.mongodb_eni_1c.mongodb_eni.private_ip
}