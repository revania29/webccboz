// Adaptasi dari Jenkinsfile contoh Linux
pipeline {
    agent any // Menjalankan di agent mana saja yang tersedia [cite: 65]

    environment {
        // GANTI 'youruser' dengan username Docker Hub Anda!
        IMAGE_NAME = 'youruser/laravel-crud-app' [cite: 68]
        REGISTRY = 'https://index.docker.io/v1/' [cite: 69]
        // ID ini harus sama dengan yang Anda buat di Jenkins
        REGISTRY_CREDENTIALS = 'dockerhub-credentials' [cite: 70]
    }

    stages {
        stage('Checkout') {
            steps {
                // Mengambil kode dari Source Control Management (Git) [cite: 72]
                checkout scm [cite: 72]
            }
        }

        stage('Build Application') {
            steps {
                // Untuk Laravel, 'build' utamanya adalah instalasi composer
                // yang sudah kita lakukan di Dockerfile.
                // Kita bisa tambahkan step validasi di sini.
                sh 'echo "Mulai build aplikasi..."' [cite: 75]
                // Contoh: Menjalankan tes (jika ada)
                // sh 'php artisan test'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Membangun image Docker menggunakan Dockerfile di repo
                    // dan memberinya tag dengan Build Number dari Jenkins [cite: 78]
                    docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}") [cite: 78]
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login ke Docker Hub menggunakan credential yang tersimpan [cite: 82]
                    docker.withRegistry(REGISTRY, REGISTRY_CREDENTIALS) { [cite: 82]

                        def tag = "${IMAGE_NAME}:${env.BUILD_NUMBER}" [cite: 83]

                        // Push tag dengan build number
                        docker.image(tag).push() [cite: 84]

                        // Beri tag 'latest' dan push juga
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
