pipeline { 

    agent any 
    environment{
        registryname = "acradactimzied"
        registryUrl = "acradactimzied.azurecr.io"
        registryCredential = "ACR"
        dockerImage = ''
    }
    stages {
        stage('checkout'){
        steps {checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/zied-tech/aks-cluster-terraform']]])}
        }
        stage('Build artiifact') {
        steps {sh "mvn clean package" }
        }
        stage('Building Docker image') {
		steps { def dockerImage = {sh "docker build -t ziedcloud2020/employeecare:1.1 ."} }
		}
        stage('push Docker image to ACR') {
		steps { 
            script{
                docker.withRegistry("http://${registryUrl}",registryCredential){
                    dockerImage.push()
                   }
                  }
            }
		}
    }
}