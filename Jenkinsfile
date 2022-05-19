pipeline { 

    agent any 
    stages {
        stage('Build artiifact') {
        steps {sh "mvn clean package" }
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
