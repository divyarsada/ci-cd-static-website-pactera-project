pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e ./web-app/*.html'
            }
        }
        
         stage('Upload updated index.html to AWS S3 bucket') {
            steps {
                withAWS(region:'us-east-1',credentials:'AWS-creds') {
                   s3Upload(pathStyleAccessEnabled:true, payloadSigningEnabled: true, file:'/web-app/index.html', bucket:'static-webapp-pactra-project')
                }
            }
        }
        
        stage("Deploy updated index.html file") {
           steps {
                ansiblePlaybook credentialsId: 'i-0115da5b203521845', disableHostKeyChecking: true, installation: 'ansible', inventory: 'web-app/hosts.inv', playbook: 'web-app/apache.yml'
            }
        }
    }
}