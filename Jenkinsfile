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

pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials-id'
        DOCKER_IMAGE = 'your-dockerhub-username/your-image-name'
        DEPLOYMENT_REPO_URL = 'https://github.com/your-username/deployment-repo.git'
        DEPLOYMENT_REPO_CREDENTIALS_ID = 'github-credentials-id'
        DEPLOYMENT_BRANCH = 'main'
        IMAGE_TAG = "v${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout Source Repo') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS_ID) {
                        sh "docker push ${DOCKER_IMAGE}:${IMAGE_TAG}"
                    }
                }
            }
        }

        stage('Update Deployment YAML') {
            steps {
                script {
                    // Clone the deployment repo
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: "*/${DEPLOYMENT_BRANCH}"]],
                        userRemoteConfigs: [[
                            url: DEPLOYMENT_REPO_URL,
                            credentialsId: DEPLOYMENT_REPO_CREDENTIALS_ID
                        ]]
                    ])
                    
                    // Update the deployment.yaml file with the new image tag
                    sh """
                    sed -i 's|image:.*|image: ${DOCKER_IMAGE}:${IMAGE_TAG}|' deployment.yaml
                    git add deployment.yaml
                    git commit -m 'Update image version to ${IMAGE_TAG}'
                    git push origin ${DEPLOYMENT_BRANCH}
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
        always {
            cleanWs()
        }
    }
}
