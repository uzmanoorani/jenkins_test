pipeline {
    agent any
    tools {
        maven 'Maven'
        jdk 'JDK 17'
    }
    environment {
        DOCKER_IMAGE = 'backend:latest'
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
        // stage('Lint') {
        //     steps {
        //         sh 'mvn checkstyle:checkstyle'
        //     }
        // }
        
        // stage('Security Scan') {
        //     steps {
        //         sh 'mvn org.owasp:dependency-check-maven:check'
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
    }
}

