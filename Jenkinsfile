pipeline {
  agent any
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
                        withCredentials([usernamePassword(credentialsId:"dockerhub",usernameVariable:"username",passwordVariable:"pass")]){
                            sh 'docker build . -t ${username}/go-violin:latest'
                            }
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
                withCredentials([usernamePassword(credentialsId:"dockerhub",usernameVariable:"username",passwordVariable:"pass")])
                {
                    sh 'docker login -u ${username} -p ${pass}'
                    sh 'docker push ${username}/go-violin:latest'
                }}}
        stage('deploy App to K8S'){
            steps {
                script {
                        kubernetesDeploy(configs: "deployment.yml", kubeconfigId: "kubernetes")
                    }
                }
        }
    }  
}