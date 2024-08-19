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
    }
}

