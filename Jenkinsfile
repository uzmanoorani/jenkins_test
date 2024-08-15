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
        // stage('Package') {
        //     steps {
        //         sh 'mvn package'
        //     }
        //     post {
        //         success {
        //             archiveArtifacts artifacts: 'target/*.jar', allowEmptyArchive: false
        //         }
        //     }
        // }
        stage('Build Docker Image') {
            steps {
                script {
                    //docker.build(DOCKER_IMAGE, '.')
                    sh 'cp target/myapp.jar .'
                    sh "docker build -t ${env.DOCKER_IMAGE} ."
                }
            }
        }
    }
}

