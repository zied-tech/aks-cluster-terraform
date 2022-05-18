pipeline { 

    agent any 
    stages {
        stage('init maven env vars') {
            steps {
                sh 'export M2_HOME=/opt/apache-maven-3.8.5'
                sh "export PATH=$PATH:$M2_HOME/bin"
                sh "mvn --version"
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
