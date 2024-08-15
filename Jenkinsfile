pipeline {
    agent any

    // tools {
    //     maven 'Maven'
    //     jdk 'JDK 17'
    // }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/uzmanoorani/jenkins_test.git'
            }
        }
        stage('Setup') {
            steps {
                sh '''
                apt-get update
                apt-get install -y openjdk-17-jdk maven
                '''
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
        }
    }
}
