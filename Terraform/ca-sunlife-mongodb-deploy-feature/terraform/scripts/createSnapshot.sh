#checking running MongoDb Server id

runningInstance=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=mongodb-1" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[InstanceId]" --region ca-central-1 --output text)
#checking mongoDb server EBS Vol id
mongodbVol=$(aws ec2 describe-volumes --query "Volumes[*].Attachments[?InstanceId=='$runningInstance']" --region ca-central-1 --output text | grep /dev/sdb  | awk '{print $6}')
#Stop instance
aws ec2 stop-instances --instance-ids $runningInstance --region ca-central-1
#Detach EBS Vol
aws ec2 detach-volume --volume-id $mongodbVol --region ca-central-1
#Create Snapshot from EBS
aws ec2 create-snapshot --volume-id $mongodbVol --description 'Backup MongDB Data Volume' --tag-specifications 'ResourceType=snapshot,Tags=[{Key=Name,Value=slf-aep-mongodb-data-volume-backup}]' --region ca-central-1
#Delete EBS
sleep 2m
aws ec2 delete-volume --volume-id $mongodbVol --region ca-central-1

#aws ec2 start-instances --instance-ids $runningInstance --region ca-central-1

#aws ec2 detach-volume --volume-id vol-02f9efae4f0fb4c6e --region ca-central-1
