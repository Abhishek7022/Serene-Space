pipeline{
  agent {
    label 'docker-agent-alpine'
  }

  stages {
    stage('Init') {
      steps{
        echo 'Starting the Init stage...'
        sh '''
        echo "Initilization complete..."
        '''
      }
    }

    stage('Build') {
      steps{
        echo 'Starting the Build stage...'
        echo "It feels great and this is my first pipleine"
      }
    }

    stage('Test') {
      steps{
        script {
          echo 'Begin Testing stage...'
          sh 'cat /etc/issue'
          sh 'free -m'
          sh 'df -h'
        }
      }
    }

    stage('Deploy') {
      steps{
        echo 'Initiate the Deployment stage...'
        echo 'Deployment complete...'
      }
    }
  }
}
