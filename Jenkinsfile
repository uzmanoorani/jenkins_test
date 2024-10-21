/////////////////////////////////////////////////
////////////////////////////////////////////////
///////////////////////////////////////////////
//////////////21/////////////////
////////////////////////////////////////////////

pipeline {
    agent any
    tools {
        maven 'Maven'
        jdk 'JDK 17'
    }
    environment {
        IMAGE_NAME = 'backend'
        ACR_NAME = 'murthyfinzlyosacr'
        SONARQUBE_SCANNER = tool name: 'SonarQubeScanner'
        SONARQUBE_URL = "http://172.17.0.3:9000"
        SONAR_PROJECT_KEY = "crud-tuto-back"
        IMAGE_TAG = 'latest'
        ACR_URL="${ACR_NAME}.azurecr.io"
        CREDENTIALS_ID = 'acr-credentials'
        JAR_FILE = 'crud-tuto-1.0.jar'
        DOCKER_IMAGE="${ACR_URL}/${IMAGE_NAME}:${IMAGE_TAG}"
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
                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                    sh """
                        ${SONARQUBE_SCANNER}/bin/sonar-scanner \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=${SONARQUBE_URL} \
                        -Dsonar.login=${SONAR_TOKEN}
                    """
                }
            }
        }
     }
        stage('Quality Gate') {
            steps {
              withSonarQubeEnv('SonarQubeServer') {
                sleep time: 30000, unit: 'MILLISECONDS'
                timeout(time: 30, unit: 'MINUTES') {
                    script {
                        def qg = waitForQualityGate()
                        if (qg.status != 'SUCCESS') {
                           error "Pipeline failed due to quality gate failure: ${qg.status}"
                           }
                           }
                           }
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${env.DOCKER_IMAGE} -f Dockerfile --build-arg JAR_FILE=target/${JAR_FILE} ."
                    }
            }
        }
        stage('Login to ACR') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: CREDENTIALS_ID, passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                        sh "echo ${PASSWORD} | docker login ${ACR_URL} --username ${USERNAME} --password-stdin"
                    }
                }
            }
        }
        stage('Push Docker Image to ACR') {
            steps {
                script {
                    sh "docker push ${env.DOCKER_IMAGE}"
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


// stage('SonarQube Analysis') {
//             steps {
//               withSonarQubeEnv('SonarQubeServer') { 
//                 withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
//                     sh """
//                         ${SONARQUBE_SCANNER}/bin/sonar-scanner \
//                         -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
//                         -Dsonar.sources=. \
//                         -Dsonar.host.url=${SONARQUBE_URL} \
//                         -Dsonar.login=${SONAR_TOKEN}
//                     """
//                 }
//             }
//         }
//      }
//         stage('Quality Gate') {
//             steps {
//               withSonarQubeEnv('SonarQubeServer') {
//                 sleep time: 30000, unit: 'MILLISECONDS'
//                 timeout(time: 30, unit: 'MINUTES') {
//                     script {
//                         def qg = waitForQualityGate()
//                         if (qg.status != 'SUCCESS') {
//                            error "Pipeline failed due to quality gate failure: ${qg.status}"
//                            }
//                            }
//                            }
//                 }
//             }
//         }

// stage('Scanning Docker Image') {
//             steps {
//                 script {
//                     def dockerImage = "${env.DOCKER_IMAGE}"
//                     sh "trivy image --timeout 40m --scanners vuln ${dockerImage}"
//                 }
//             }
//         }