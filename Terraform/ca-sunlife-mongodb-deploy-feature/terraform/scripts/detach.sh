runningInstance=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=mongodb_1" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[InstanceId]" --region ca-central-1 --output text)
aws ec2 stop-instances --instance-ids ${runningInstance} --region ca-central-1
mongodbVol=$(aws ec2 describe-volumes --query "Volumes[*].Attachments[?InstanceId=='$runningInstance']" --region ca-central-1 --output text | grep /dev/sdb  | awk '{print $6}')
aws ec2 detach-volume --volume-id ${mongodbVol} --region ca-central-1
