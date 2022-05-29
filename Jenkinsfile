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
            sh('''
                export CURRENT_VERSION=$(cat VERSION)
                sed -i -r 's|employeecare:.*|employeecare:'"$CURRENT_VERSION"'|g'  k8s/deployment.yaml
                export NEXT_VERSION=\$(cat VERSION | awk -F. -v OFS=. '{\$NF += 1 ; print}');
                echo \$NEXT_VERSION > VERSION;
                git commit -am 'Setting next version and updating app deployment.yaml';
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
