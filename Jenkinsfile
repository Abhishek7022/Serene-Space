pipeline {
    agent {
        label 'worker'
    }

    stages {
        stage('Init') {
            steps {
                script {
                    echo 'Starting the Init stage...'
                    sh '''
                    echo "Initialization complete..."
                    '''
                }
            }
        }

        stage('Build') {
            steps {
                echo 'Starting the Build stage...'
                echo "It feels great and this is my first pipeline"
            }
        }

        stage('Test') {
            steps {
                script {
                    echo 'Begin Testing stage...'
                    sh 'cat /etc/issue'
                    sh 'free -m'
                    sh 'df -h'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo 'Initiate the Deployment stage...'
                    echo 'Deployment complete...'
                }
            }
        }
    }
}
