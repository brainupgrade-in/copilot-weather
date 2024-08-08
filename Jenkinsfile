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
                environment name: 'TAG_NAME', value: '.+'
            }
            steps {
                sh 'echo "Building..."'
                // Add your build commands here
            }
        }

        stage('Test') {
            when {
                environment name: 'TAG_NAME', value: '.+'
            }
            steps {
                sh 'echo "Testing..."'
                // Add your test commands here
            }
        }

        stage('Deploy') {
            when {
                environment name: 'TAG_NAME', value: '.+'
            }
            steps {
                sh 'echo "Deploying..."'
                // Add your deployment commands here
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
