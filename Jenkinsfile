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
        stage('Build and push image to ACR') {
            steps {
                script {
                    def version = readFile('VERSION')
                    def patch = version.trim()

                    docker.withRegistry("http://${registryUrl}",registryCredential) {
                        def image = docker.build('acradactimzied.azurecr.io/employeecare:latest')
                        image.push(patch)
                        
                    sh "NEXT_VERSION=\$(cat VERSION | awk -F. -v OFS=. '{\$NF += 1 ; print}'); echo -n \$NEXT_VERSION > VERSION"
                    sh "git add VERSION && git commit -qm 'Setting next version to \$(cat VERSION) && git -q push"
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
