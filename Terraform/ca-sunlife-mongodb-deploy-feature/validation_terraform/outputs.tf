output "private_dns" {
    value = "${aws_instance.ec2.private_dns}"
}

output "private_ip" {
    value = "${aws_instance.ec2.private_ip}"
}

output "ec2_arn" {
    value = "${aws_instance.ec2.arn}"
}

output "all_tags" {
    value = "${aws_instance.ec2.tags_all}"
}