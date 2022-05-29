pipeline {

    agent any
def readcounter = readFile(file: 'version.txt')
readcounter=readcounter.toInteger() +1
def version= "Version" + readcounter
println(version)
stages {
  stage (Build and Package) {
    steps {
        
    script {
      
      if (fileExists()) {
        def readcounter =    readFile(file: 'version.txt')
        readcounter = readcounter.toInteger() +1
        def version= "Version" + readcounter
        println(version)
        bat 'mvn package -Dartifactversion=' + "${version}"
        writeFile(file: 'version.txt',    text:readcounter.toString())
      } 
      else {
        currentBuild.result = "FAILURE"
      } 
    
    } 
    echo "Build and Package Completed"
  }
 }
}
}
