// Jenkins Pipeline for Serene-Space Website
pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockins'
        DOCKER_IMAGE = 'abhishek7022/seabiscuit'
        DEPLOYMENT_REPO_URL = 'https://github.com/Abhishek7022/Argo-CD-k8s.git'
        DEPLOYMENT_REPO_CREDENTIALS_ID = 'gitkins'
        DEPLOYMENT_BRANCH = 'master'
        IMAGE_TAG = "v${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout Source Repository') {
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
                    def deployFile1 = "namespaces/serene/ss-dev/deployment.yaml"
                    def deployFile2 = "namespaces/serene/ss-prod/deployment.yaml"

                    sh """
                    sed -i 's|image:.*|image: ${DOCKER_IMAGE}:${IMAGE_TAG}|' ${deployFile1}
                    sed -i 's|image:.*|image: ${DOCKER_IMAGE}:${IMAGE_TAG}|' ${deployFile2}

                    git add ${deployFile1}
                    git add ${deployFile2}
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
