pipeline { 

    agent any 
    stages {
        stage('Build artiifact') {
        steps {sh "mvn clean package" }
        }
        stage('Building our image') {
		steps { script { dockerImage = docker.build registry + ":$BUILD_NUMBER" } }
		}
       
    }
}
