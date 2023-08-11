resource "aws_security_group" "mongodb_sg" {
    name        = var.sg_name[0]
    description = var.sg_name[1]
    vpc_id         = var.vpc_id

    dynamic "ingress" {
        for_each = var.sg_ingress
        content {
            from_port       = ingress.value[0]
            to_port         = ingress.value[1]
            protocol        = ingress.value[2]
            description     = ingress.value[3]
            cidr_blocks     = ingress.value[5] ? null : "${split(",", var.sg_ingress.value[4])}"
            self            = ingress.value[5]
        }
    }

    dynamic "egress" {
        for_each = var.sg_ingress
        content {
            from_port       = egress.value[0]
            to_port         = egress.value[1]
            protocol        = egress.value[2]
            description     = egress.value[3]
            cidr_blocks     = egress.value[5] ? null : "${split(",", var.sg_egress.value[4])}"
            self            = egress.value[5]
        }
    }
}