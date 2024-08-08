pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "brainupgrade/copilot-weather"
        BRANCH_NAME = "${env.BRANCH_NAME}"
        TAG_NAME = "${env.TAG_NAME}"
    }

    stages {
        stage('Build') {
            when {
                expression {
                    return BRANCH_NAME == 'main' || (TAG_NAME != null && TAG_NAME.startsWith('v'))
                }
            }
            steps {
                script {
                    def tagName = env.GIT_TAG
                    docker.build("${DOCKER_IMAGE}:${tagName}")
                }
            }
        }
        stage('Deploy to Integration') {
            when {
                expression {
                    return BRANCH_NAME == 'main' || (TAG_NAME != null && TAG_NAME.startsWith('v'))
                }
            }
            steps {
                script {
                    def tagName = env.GIT_TAG
                    // sh "kubectl set image deployment/copilot-weather --image=${DOCKER_IMAGE}:${tagName} --namespace=integration"
                    echo "Deploying to Integration"
                }
            }
        }
        stage('Approval for UAT') {
            when {
                expression {
                    return BRANCH_NAME == 'main' || (TAG_NAME != null && TAG_NAME.startsWith('v'))
                }
            }
            steps {
                input message: 'Deploy to UAT?', ok: 'Deploy'
            }
        }
        stage('Deploy to UAT') {
            when {
                expression {
                    return BRANCH_NAME == 'main' || (TAG_NAME != null && TAG_NAME.startsWith('v'))
                }
            }
            steps {
                script {
                    def tagName = env.GIT_TAG
                    // sh "kubectl set image deployment/copilot-weather --image=${DOCKER_IMAGE}:${tagName} --namespace=uat"
                    echo "Deploying to UAT"
                }
            }
        }
        stage('Approval for PROD') {
            when {
                expression {
                    return BRANCH_NAME == 'main' || (TAG_NAME != null && TAG_NAME.startsWith('v'))
                }
            }
            steps {
                input message: 'Deploy to PROD?', ok: 'Deploy'
            }
        }
        stage('Deploy to PROD') {
            when {
                expression {
                    return BRANCH_NAME == 'main' || (TAG_NAME != null && TAG_NAME.startsWith('v'))
                }
            }
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