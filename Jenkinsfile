pipeline {
    agent {
            docker {
                image 'docker:19.03'  // Image Docker officielle avec Docker préinstallé
                args '-v /var/run/docker.sock:/var/run/docker.sock'  // Montez le socket Docker de l'hôte pour l'utiliser à l'intérieur du conteneur
            }
        }
    environment { 
	    DOCKER_USERNAME =  'bigben29'
	    GITHUB_REPO_URL =  'https://github.com/BenMessGHF/cicd-testing-java-cours'  }

    tools {
        maven 'Maven'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'm1ch1_OK', url: "${env.GITHUB_REPO_URL}"
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package -X'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_USERNAME}/dockercred1:${env.BUILD_NUMBER}", '.')
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'test-jenkins') {
                        docker.image("${env.DOCKER_USERNAME}/dockercred1:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }
    }
}