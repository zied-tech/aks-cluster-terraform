pipeline { 

    agent any 
    stages {

        stage('Cloning our Git') {
        steps { git 'https://github.com/zied-tech/aks-cluster-terraform'
        }
        }
        stage('Mvn Clean') {
        steps {sh "mvn clean" }
        }
        stage('Mvn Compile') {
        steps {sh "mvn compile" }
        }
        stage('Mvn Install') {
        steps {sh "mvn install" }
        }
    stage('Cleaning up')
        {
        steps
            { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            } 
        }
    }
}