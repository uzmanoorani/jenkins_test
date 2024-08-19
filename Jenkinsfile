pipeline {
    agent any
    tools {
        maven 'Maven'
        jdk 'JDK 17'
    }
    environment {
        DOCKER_IMAGE = 'backend:latest'
        SONARQUBE_SCANNER = tool name: 'SonarQubeScanner'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/uzmanoorani/jenkins_test.git'
            }
            }
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQubeServer') { 
                    sh "${SONARQUBE_SCANNER}/bin/sonar-scanner \
                        -Dsonar.projectKey=crud-tuto-back \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://172.17.0.3:9000 \
                        -Dsonar.login=sqp_b9bc874205ffe2208f2845a245a855521e2b5878"
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'cp target/crud-tuto-1.0.jar .'
                    sh "docker build -t ${env.DOCKER_IMAGE} ."
                }
            }
        }
        stage('Install Trivy') {
            steps {
                script {
                    // Install Trivy
                    sh '''
                        # Install dependencies for Trivy
                         apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*


                        # Download and install Trivy
                        TRIVY_VERSION=0.39.0
                        curl -LO https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_0.39.0_Linux-64bit.tar.gz
                        tar zxvf trivy_0.39.0_Linux-64bit.tar.gz
                        mv trivy /usr/local/bin/
                        rm trivy_0.39.0_Linux-64bit.tar.gz
                    '''
                }
            }
        }

        stage('Scan Existing Docker Image') {
            steps {
                script {
                    // Scan the existing Docker image with Trivy
                    def dockerImage = "${env.DOCKER_IMAGE_NAME}"
                    sh "trivy image --exit-code 1 ${dockerImage}"
                }
            }
        }
        // stage('Download Trivy and Scan Image') {
        //     steps {
        //         script {
        //             sh "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image ${env.DOCKER_IMAGE}"
        //         }
        //     }
        // }
    }
   
}

