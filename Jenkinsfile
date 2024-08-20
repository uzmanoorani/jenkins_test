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
        // stage('Install Trivy') {
        //     steps {
        //         script {
        //             sh '''
        //                 TRIVY_VERSION=0.39.0
        //                 curl -LO https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_0.39.0_Linux-64bit.tar.gz
        //                 tar zxvf trivy_0.39.0_Linux-64bit.tar.gz
        //                 mv trivy /usr/local/bin/
        //                 rm trivy_0.39.0_Linux-64bit.tar.gz
        //             '''
        //         }
        //     }
        // }

        stage('Scanning Docker Image') {
            steps {
                script {
                    def dockerImage = "${env.DOCKER_IMAGE}"
                   // sh "trivy image --timeout 40m --exit-code 1 ${dockerImage}"
                    sh "trivy image --timeout 40m --scanners vuln --exit-code 1 ${dockerImage}"
                }
            }
        }
    }
   
}

