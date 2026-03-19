pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
        EC2_HOST = credentials('ec2-host')
        DOCKERHUB_USER = "${DOCKERHUB_CREDS_USR}"
        DOCKERHUB_PASS = "${DOCKERHUB_CREDS_PSW}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Prepare') {
            steps {
                sh 'chmod +x build.sh deploy.sh'
            }
        }

        // ✅ ADD THIS STAGE
        stage('Set Environment') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        env.ENV = "prod"
                    } else {
                        env.ENV = "dev"
                    }
                    echo "ENV is set to: ${env.ENV}"
                }
            }
        }

        stage('Build and Push') {
            steps {
                sh '''
                    export ENV=$ENV
                    export DOCKERHUB_USER=$DOCKERHUB_USER
                    export DOCKERHUB_PASS=$DOCKERHUB_PASS
                    ./build.sh
                '''
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh '''
                        export DOCKER_PASS=$DOCKERHUB_PASS
                        IMAGE_NAME="$DOCKERHUB_USER/react-app-prod:latest"

                        ./deploy.sh $EC2_HOST $DOCKERHUB_USER $IMAGE_NAME
                    '''
                }
            }
        }
    }
}
