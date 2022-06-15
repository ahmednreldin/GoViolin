pipeline {
  agent any
  environment{
      DOCKER_CREDENTIALS = credentials('DockerHub')
  }
    stages {
        stage('Git Clone') {
            steps { 
                git branch:'master', url: 'https://github.com/ahmednreldin/GoViolin/'
                }
            }
        stage('Docker Build') {
            steps {
                script{
                    try{
                            sh 'docker build . -t ${DOCKER_CREDENTIALS_USR}/go-violin:latest'  
                        }
                    catch(error){
                        echo "Caught: ${error.getMessage()}"
                        currentBuild.result = 'FAILURE'
                        throw error
                     }}      
                    }
             post {
                failure { 
                    slackSend (color: "#ff3300", message: """ Stage Docker build 
                           Status of pipeline: ${currentBuild.fullDisplayName}
                           has result ${currentBuild.result}""")
                        } 
                }
            }
        stage ('Push Image to Docker Hub'){
            steps{
                    sh 'docker login -u ${DOCKER_CREDENTIALS_USR} -p ${DOCKER_CREDENTIALS_PSW}'
                    sh 'docker push ${DOCKER_CREDENTIALS_USR}/go-violin:latest'
                }
                
                }
        stage('deploy App to K8S'){
            steps {
                script {
                        kubernetesDeploy(configs: "deployment.yml", kubeconfigId: "kubernetes")
                    }
                }
        }
    }  
}