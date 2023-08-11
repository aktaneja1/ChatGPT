//Restore from snapshoot
def restore_from_snapshot(account_name) {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${account_name}", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
    {
        sh '''
        runningInstance=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=mongodb-1" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[InstanceId]" --region ca-central-1 --output text)
        echo "##running mongodb-1: ${runningInstance}"
        aws ec2 stop-instances --instance-ids ${runningInstance} --region ca-central-1
        sleep 2m
        newMongodbVol=$(aws ec2 describe-volumes --filters Name=tag:create_from_backup,Values=true --query "Volumes[*].VolumeId" --region ca-central-1 --output text)
        echo "##new mongodb-1 dataVol: ${newMongodbVol}"
        mongodbVol=$(aws ec2 describe-volumes --query "Volumes[*].Attachments[?InstanceId=='$runningInstance']" --region ca-central-1 --output text | grep /dev/sdb  | awk '{print $6}')
        echo "##current mongodb-1 dataVol: ${mongodbVol}"
        aws ec2 detach-volume --volume-id ${mongodbVol} --region ca-central-1
        sleep 30s
        aws ec2 attach-volume --volume-id ${newMongodbVol} --instance-id ${runningInstance} --device /dev/sdb --region ca-central-1
        sleep 30s
        aws ec2 start-instances --instance-ids ${runningInstance} --region ca-central-1
        aws ec2 delete-volume --volume-id ${mongodbVol} --region ca-central-1
        echo "##describe-instance"
        aws ec2 describe-instances --filters "Name=tag:Name,Values=mongodb-1" --region ca-central-1
        '''
    }
}

//Create Snapshot
def backup(account_name) {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${account_name}", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
    {
        sh '''
        runningInstance=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=mongodb-1" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[InstanceId]" --region ca-central-1 --output text)
        echo "##running mongodb-1: ${runningInstance}"
        aws ec2 stop-instances --instance-ids ${runningInstance} --region ca-central-1
        sleep 2m
        currentMongodbVol=$(aws ec2 describe-volumes --query "Volumes[*].Attachments[?InstanceId=='$runningInstance']" --region ca-central-1 --output text | grep /dev/sdb  | awk '{print $6}')
        echo "##current mongodb-1 dataVol: ${currentMongodbVol}"
        aws ec2 create-snapshot --volume-id ${currentMongodbVol} --description 'Backup MongDB Data Volume' --tag-specifications 'ResourceType=snapshot,Tags=[{Key=Name,Value=slf-aep-mongodb-data-volume-backup}]' --region ca-central-1
        sleep 3m
        snapshotBackup=$(aws ec2 describe-snapshots --filters "Name=tag:Name,Values=slf-aep-mongodb-data-volume-backup" --query "sort_by(Snapshots, &StartTime)[-1].SnapshotId" --region ca-central-1 --output text)
        echo "##new data vol snapshot id: ${snapshotBackup}"
        '''
    }
}
        

return this