pipeline { 

    agent any 
    environment{
        registryname = "employeecare"
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
        stage('Build') {
            steps {
                script {
                    def version = readFile('VERSION')
                    def versions = version.split('\\.')
                    def major = versions[0]
                    def minor = versions[0] + '.' + versions[1]
                    def patch = version.trim()

                    docker.withRegistry("http://${registryUrl}",registryCredential) {
                        def image = docker.build('acradactimzied.azurecr.io/employeecare:latest')
                        image.push()
                        image.push(major)
                        
                    }
                }
            }
        }

        stage('email notifiication'){
		steps {
        	emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
        	recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
        	subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
    	}
    }
        
    }

}