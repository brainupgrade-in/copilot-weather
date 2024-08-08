pipeline {
    agent any

    environment {
        TAG_NAME = ""
        SHOULD_BUILD = "false"
    }

    stages {
        stage('Initialize') {
            steps {
                script {
                    // Extract the tag name if available
                    if (env.GIT_BRANCH?.startsWith('refs/tags/')) {
                        env.TAG_NAME = env.GIT_BRANCH.replaceFirst('refs/tags/', '')
                    }

                    // Determine if the build should proceed
                    if (env.BRANCH_NAME == 'main' || (env.TAG_NAME && env.TAG_NAME.startsWith('v'))) {
                        env.SHOULD_BUILD = "true"
                    } else {
                        env.SHOULD_BUILD = "false"
                        error("Skipping build as the branch is not 'main' and the tag does not start with 'v'.")
                    }
                }
            }
        }

        stage('Checkout') {
            when {
                expression { return env.SHOULD_BUILD == 'true' }
            }
            steps {
                git url: 'https://github.com/brainupgrade-in/copilot-weather.git', branch: env.BRANCH_NAME
            }
        }

        stage('Build') {
            when {
                expression { return env.SHOULD_BUILD == 'true' }
            }
            steps {
                sh 'echo "Building..."'
                // Add your build commands here
            }
        }

        stage('Test') {
            when {
                expression { return env.SHOULD_BUILD == 'true' }
            }
            steps {
                sh 'echo "Testing..."'
                // Add your test commands here
            }
        }

        stage('Deploy') {
            when {
                expression { return env.SHOULD_BUILD == 'true' }
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
