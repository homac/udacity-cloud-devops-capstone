pipeline {
	agent any
	stages {
		stage('Upload to AWS') {
			steps {
				withAWS(region:'eu-central-1',credentials:'aws-static') {
					s3Upload(file:'index.html', bucket:'udacity-jenkins-macht', path:'index.html')
				}
				sh 'echo "Hello World"'
				sh '''
					echo "Multiline shell steps work too"
					ls -lah
				'''
			}
		}
	}
}

