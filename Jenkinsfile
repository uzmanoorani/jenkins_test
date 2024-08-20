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
                        -Dsonar.host.url=http://172.17.0.2:9000 \
                        -Dsonar.login=${SONAR_TOKEN}"
                }
            }
        }
        stage('Quality Gate') {
            steps {
                script {
                    def qualityGate = waitForQualityGate()
                    if (qualityGate.status != 'OK') {
                        sh 'exit 1'
                    }
                }
            }
        }
        // stage('Quality Gate') {
        //     steps {
        //         script {
        //                 def qualityGate = waitForQualityGate()
        //                 if (qualityGate.status != 'OK') {
        //                     error "Pipeline failed due to quality gate status: ${qualityGate.status}"
        //                 }
                    
        //         }
        //     }
        // }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'cp target/crud-tuto-1.0.jar .'
                    sh "docker build -t ${env.DOCKER_IMAGE} ."
                }
            }
        }

        stage('Scanning Docker Image') {
            steps {
                script {
                    def dockerImage = "${env.DOCKER_IMAGE}"
                    sh "trivy image --timeout 40m --scanners vuln ${dockerImage}"
                }
            }
        }
    }
   
}

