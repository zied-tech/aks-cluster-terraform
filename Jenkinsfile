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
                        
                    //sh "NEXT_VERSION=\$(cat VERSION | awk -F. -v OFS=. '{\$NF += 1 ; print}'); echo -n \$NEXT_VERSION > VERSION"
                    
                    }
                }
            }
        }
        stage('Bump up to next version') {
        environment { 
            GIT_AUTH = credentials('github_id') 
        }
        steps {
            sh "export NEXT_VERSION=\$(cat VERSION | awk -F. -v OFS=. '{\$NF += 1 ; print}');"
            sh "echo \$NEXT_VERSION > VERSION;"
            sh "git config user.name 'Zied KHELIFI'; git config user.email 'zied.khelifi@esprit.tn';"
            sh('''
                git config --local credential.helper "!f() { echo username=\\$GIT_AUTH_USR; echo password=\\$GIT_AUTH_PSW; }; f"
                git push origin HEAD:main
            ''')
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
