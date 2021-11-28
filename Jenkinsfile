pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e ./web-app/*.html'
            }
        }
        
        stage("Deploy Updated index.html file") {
           steps {
                ansiblePlaybook credentialsId: 'i-0115da5b203521845', disableHostKeyChecking: true, installation: 'ansible', inventory: 'web-app/hosts.inv', playbook: 'web-app/apache.yml'
            }
        }
    }
}