def init(account_name) {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${account_name}", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
    {
        sh '''
            cd terraform && ls -l
            curl -o tf.zip https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip ; yes | unzip tf.zip
            ./terraform --version
            ./terraform init
        '''
    }   
}

def initialize(account_name) {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${account_name}", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
    {
        sh 'cd terraform && cat env/dev_vars.tfvars'
    }
}

def plan(account_name) {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${account_name}", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
    {
        sh 'cd terraform && ./terraform plan -var-file=env/dev_vars.tfvars'
    }
}

def apply(account_name) {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${account_name}", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
    {
        sh 'cd terraform && ./terraform apply -var-file=env/dev_vars.tfvars --auto-approve'
    }
}

def destroy(account_name) {
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${account_name}", accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']])
    {
        sh 'cd terraform && ./terraform destroy -var-file=env/dev_vars.tfvars --auto-approve'
    }
}

return this