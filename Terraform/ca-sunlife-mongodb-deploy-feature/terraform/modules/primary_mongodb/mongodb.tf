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

  ebs_backup = {
    create_from_backup       = "true"
  }
}

//Create EC2
resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.mongodb[1]
  //subnet_id              = var.aws_subnet //var.aws_subnet.az_1a
  //vpc_security_group_ids = [var.aws_security_group]
  tags                   = local.tag_set
  volume_tags            = local.tag_set
  network_interface {
    network_interface_id = var.network_interface
    device_index         = 0
  }
  user_data              = templatefile("./modules/templates/userdata_primary.txt", { pri = var.network_interface_pri, sec1 = var.network_interface_sec1, sec2 = var.network_interface_sec2, hostname = var.mongodb[4]})
}

//query Current EBS Vol id
/*
data "aws_ebs_volume" "mongo_data" {
  depends_on  = [aws_ec2_instance_state.mongodb_stopped]
  most_recent = true
  filter {
    name   = "size"
    values = ["200"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.mongodb[4]}"]
  }
}*/

/*//Stop EC2
resource "aws_ec2_instance_state" "mongodb_stopped" {
  depends_on  = [aws_instance.ec2]
  instance_id = aws_instance.ec2.id
  state       = "stopped"
  force       = true
}

//detach ebs
resource "null_resource" "detach_mongo_vol" {
  depends_on = [aws_ec2_instance_state.mongodb_stopped]
  provisioner "local-exec" {
    command = "aws ec2 detach-volume --volume-id ${data.aws_ebs_volume.mongo_data.id} --region ca-central-1 && aws ec2 delete-volume --volume-id ${data.aws_ebs_volume.mongo_data.id} --region ca-central-1"
  }
}*/

//create data ebs from snapshot
resource "aws_ebs_volume" "mongodb_datavol" {
  //depends_on        = [null_resource.detach_mongo_vol]
  availability_zone = var.availability_zone
  size              = 200
  type              = "gp3"
  iops              = 3000
  throughput        = 125
  tags              = "${merge(local.tag_set, local.ebs_backup)}"
  snapshot_id       = var.snapshot_id
  //kms_key_id        = var.aws_kms_key_arn
}
/*
//Attach EBS to EC2
resource "aws_volume_attachment" "mongodb_volume" {
  depends_on  = [aws_ebs_volume.mongodb_datavol]
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.mongodb_datavol.id
  instance_id = aws_instance.ec2.id
  //skip_destroy = true
  force_detach = true
}

//Start EC2
resource "aws_ec2_instance_state" "mongodb_running" {
  depends_on  = [aws_volume_attachment.mongodb_volume]
  instance_id = aws_instance.ec2.id
  state       = "running"
  force       = true
}


#create snapshot when destroying
resource "null_resource" "create_mongo_vol_snapshot_when_destroy" {
  provisioner "local-exec" {
    command = "chmod +x ./scripts/createSnapshot.sh && sh ./scripts/createSnapshot.sh"
    environment = {
      type = "backup"
    }
    when = destroy
  }
}*/