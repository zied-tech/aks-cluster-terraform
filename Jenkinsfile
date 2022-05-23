pipeline { 

    agent any 
    stages {
        stage('checkout'){
        steps {checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/zied-tech/aks-cluster-terraform']]])}
        }
        stage('Build artiifact') {
        steps {sh "mvn clean package" }
        }
        stage('Building Docker image') {
		steps { sh "docker build -t ziedcloud2020/employeecare:1.1 ." }
		}
        stage('push Docker image') {
		steps { sh "docker push ziedcloud2020/employeecare:1.1" }
		}
    }
}