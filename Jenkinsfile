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
                    sh 'docker build . -t homac/udacity-cloud-devops-capstone'
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
                    sh 'docker tag homac/udacity-cloud-devops-capstone:latest homac/udacity-capstone-project'
                    sh 'docker push homac/udacity-cloud-devops-capstone'
            }
                }
            }
        }	    
    }
}

