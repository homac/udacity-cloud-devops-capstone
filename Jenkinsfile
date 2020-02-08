pipeline {
    agent any
    stages {
	    
        stage('Lint HTML') {
        steps {
          sh 'tidy -q -e *.html'
          }
		  }
        
         stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    sh 'sudo docker build . -t homac/udacity-cloud-devops-capstone'
                    }
                }
         }
             
         stage('Push Docker Image') {
             when {
                branch 'master'
            }
            steps {
                script {
                 withDockerRegistry( credentialsId: "docker_hub_login") {
                    sh 'sudo docker tag homac/udacity-cloud-devops-capstone:latest homac/udacity-capstone-project'
                    sh 'sudo docker push homac/udacity-cloud-devops-capstone'
            }
                }
            }
        }	    
    }
}

