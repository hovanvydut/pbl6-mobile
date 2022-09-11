pipeline{
	agent any
	
	triggers {
		githubPush()
	}
	
	environment {
		REMOTE_SERVER_DOMAIN = 'jenkins-slave-1.silk-cat.software'
	}

	stages {
		stage('Git clone') {
			steps {
				git branch: 'master', url: 'git@github.com:hovanvydut/pbl6-mobile.git/', credentialsId: 'win_10_personal_key'
			}
		}

		stage('Build') {
			steps {
				sh '''
					flutter build apk --flavor production --target lib/main_production.dart --target-platform android-arm64
				'''
			}
		}
	}

	post {
		always {
            echo 'Always message'
		}

		success {
            echo 'Success message'
        }

		failure {
            echo 'Failed :( message'
        }

        changed {
            echo 'Things were different before...'
        }

		aborted  {
			echo "Aborted message"
		}
	}
}