pipeline {
    agent any

    environment {
        TAG_NAME = ""
        SHOULD_BUILD = "false"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Check Tag') {
            steps {
                script {
                    // Get the tag associated with the latest commit
                    def tagName = sh(script: 'git tag --points-at HEAD', returnStdout: true).trim()
                    
                    // Check if a tag is associated with the latest commit
                    if (tagName) {
                        echo "Tag found: ${tagName}"
                        // Set an environment variable to use in other stages
                        env.TAG_NAME = tagName
                    } else {
                        echo "No tag associated with the latest commit."
                        // Skip the rest of the stages
                        currentBuild.result = 'SUCCESS'
                        error('No tag associated with the latest commit, skipping build stages.')
                    }
                }
            }
        }

        stage('Build') {
            when {
                environment name: 'TAG_NAME', value: 'v.+'
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
                environment name: 'TAG_NAME', value: 'v.+'
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
                environment name: 'TAG_NAME', value: 'v.+'
            }            
            steps {
                input message: 'Deploy to UAT?', ok: 'Deploy'
            }
        }
        stage('Deploy to UAT') {
            when {
                environment name: 'TAG_NAME', value: 'v.+'
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
                environment name: 'TAG_NAME', value: 'v.+'
            }            
            steps {
                input message: 'Deploy to PROD?', ok: 'Deploy'
            }
        }
        stage('Deploy to PROD') {
            when {
                environment name: 'TAG_NAME', value: 'v.+'
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

    post {
        always {
            sh 'echo "Cleaning up..."'
            // Add any cleanup steps here
        }
        success {
            sh 'echo "Build succeeded!"'
        }
        failure {
            sh 'echo "Build failed!"'
        }
    }
}
