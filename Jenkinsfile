pipeline {
    agent any

    environment {
        IMAGE_NAME = 'revania/laravel-crud-app' [cite: 68]
        REGISTRY = 'https://index.docker.io/v1/' [cite: 69]
        REGISTRY_CREDENTIALS = 'credentials-webcc' [cite: 70]
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm [cite: 72]
            }
        }

        stage('Build Application') {
            steps {
                sh 'echo "Mulai build aplikasi..."' [cite: 75]
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}") [cite: 78]
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry(REGISTRY, REGISTRY_CREDENTIALS) { [cite: 82]

                        def tag = "${IMAGE_NAME}:${env.BUILD_NUMBER}" [cite: 83]

                        docker.image(tag).push() [cite: 84]

                        docker.image(tag).push('latest') [cite: 85]
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline build selesai.' [cite: 88]
        }
    }
}
