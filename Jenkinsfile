pipeline {
    agent any
    tools {
        maven 'Maven'
        jdk 'JDK 17'
    }
    environment {
        DOCKER_IMAGE = 'backend'
        ACR_NAME = 'murthyfinzlyosacr'
        SONARQUBE_SCANNER = tool name: 'SonarQubeScanner'
        IMAGE_TAG = 'latest'
        ACR_URL = "${ACR_NAME}.azurecr.io"
        CREDENTIALS_ID = 'acrc-credentials'
        JAR_FILE = 'crud-tuto-1.0.jar'
        DOCKER_IMAGE = "${ACR_URL}/${IMAGE_NAME}:${IMAGE_TAG}"
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
        // stage('SonarQube Analysis') {
        //     steps {
        //         withSonarQubeEnv('SonarQubeServer') { 
        //             sh "${SONARQUBE_SCANNER}/bin/sonar-scanner \
        //                 -Dsonar.projectKey=crud-tuto-back \
        //                 -Dsonar.sources=. \
        //                 -Dsonar.host.url=http://172.17.0.2:9000 \
        //                 -Dsonar.login=sqp_b9bc874205ffe2208f2845a245a855521e2b5878"
        //         }
        //     }
        // }
        // stage('Quality Gate') {
        //     steps {
        //         script {
        //             def qualityGate = waitForQualityGate()
        //             if (qualityGate.status != 'OK') {
        //                 sh 'exit 1'
        //             }
        //         }
        //     }
        // }
        
        stage('Build Docker Image') {
            steps {
                script {
                    //sh "docker build -t ${env.DOCKER_IMAGE} -f Dockerfile --build-arg JAR_FILE=target/crud-tuto-1.0.jar ."
                    sh "docker build -t ${env.DOCKER_IMAGE} -f Dockerfile --build-arg JAR_FILE=target/${JAR_FILE} ."
                    
                }
            }
        }

        // stage('Scanning Docker Image') {
        //     steps {
        //         script {
        //             def dockerImage = "${env.DOCKER_IMAGE}"
        //             sh "trivy image --timeout 40m --scanners vuln ${dockerImage}"
        //         }
        //     }
        // }
    }  
}