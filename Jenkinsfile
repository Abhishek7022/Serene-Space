pipeline{
  agent {
    docker { image 'node:16-alpine'}
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
          echo "OS: ${env.OS}"
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
