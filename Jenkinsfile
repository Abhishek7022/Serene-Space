pipeline{
  agent docker-alpine

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
          sh 'top'
        }
      }
    }

    stage('Deploy') {
      steps{
        echo 'Initiate the Deployment stage...'
      }
    }
  }
}
