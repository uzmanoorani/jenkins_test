pipeline {
    agent any
    tools {
        maven 'Maven'
        jdk 'JDK 17'
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
        stage('Package') {
            steps {
                sh 'mvn package'
            }
            post {
                success {
                    arcdef customImage = docker.build("${env.DOCKER_IMAGE}", ".")hiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: false
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    //docker.build(DOCKER_IMAGE, '.')
                    def customImage = docker.build("${env.DOCKER_IMAGE}", ".")
                }
            }
        }
    }
}

