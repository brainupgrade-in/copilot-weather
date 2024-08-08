pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "brainupgrade/copilot-weather"
    }

    stages {
        stage('Build') {
            when {
                tag "*"
            }
            steps {
                script {
                    def tagName = env.GIT_TAG
                    docker.build("${DOCKER_IMAGE}:${tagName}")
                }
            }
        }
        stage('Deploy to Integration') {
            steps {
                script {
                    def tagName = env.GIT_TAG
                    // sh "kubectl set image deployment/copilot-weather --image=${DOCKER_IMAGE}:${tagName} --namespace=integration"
                    echo "Deploying to Integration"
                }
            }
        }
        stage('Approval for UAT') {
            steps {
                input message: 'Deploy to UAT?', ok: 'Deploy'
            }
        }
        stage('Deploy to UAT') {
            steps {
                script {
                    def tagName = env.GIT_TAG
                    // sh "kubectl set image deployment/copilot-weather --image=${DOCKER_IMAGE}:${tagName} --namespace=uat"
                    echo "Deploying to UAT"
                }
            }
        }
        stage('Approval for PROD') {
            steps {
                input message: 'Deploy to PROD?', ok: 'Deploy'
            }
        }
        stage('Deploy to PROD') {
            steps {
                script {
                    def tagName = env.GIT_TAG
                    // sh "kubectl set image deployment/copilot-weather --image=${DOCKER_IMAGE}:${tagName} --namespace=prod"
                    echo "Deploying to PROD"
                }
            }
        }
    }
}