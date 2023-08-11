def get_secret(account_name) {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${account_name}", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
    {
      
        mongodb = sh(returnStdout: true, script: 'aws secretsmanager get-secret-value --secret-id dev/mongodb --query "SecretString" --region ca-central-1 --output text | awk -F',' '{print $2}' |awk -F':' '{print $2}' | sed 's/\"//g'').trim()
            
    }
    
}

return this