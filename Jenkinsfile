pipeline { 

    agent any 
    stages {
        stage('Build artiifact') {
        steps {sh "mvn clean package" }
        }
        stage('Building Docker image') {
		steps { sh "docker build -t ziedcloud2020/employeecare:1.1 ." }
		}
    }
}
