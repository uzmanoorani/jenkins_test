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
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.8.6-openjdk-17'
                    args '-v /root/.m2:/root/.m2' // Optional: To use the local Maven repository
                }
            }
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
