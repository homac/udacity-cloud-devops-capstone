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
                        sh 'docker tag homac/udacity-cloud-devops-capstone homac/udacity-cloud-devops-capstone:${GIT_COMMIT}'
                        sh 'docker push homac/udacity-cloud-devops-capstone:${GIT_COMMIT}'
                    }
                }
            }
        }

        stage('Deploy to k8s') {
            when {
                branch 'master'
            }
            steps {
                script {
                    withAWS(credentials:'aws_credentials') {
                        sh 'curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl'
                        sh 'chmod +x ./kubectl'
                        sh 'cat ./k8s/app-deployment.yaml | sed "s/{{GIT_COMMIT}}/$GIT_COMMIT/g" | ./kubectl apply -f -'
                        sh './kubectl apply -f ./k8s/app-service.yaml'
                    }
                 }
            }
        }	    

    }
}

