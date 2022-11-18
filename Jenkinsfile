pipeline{
	agent {
  		label 'agentflutter'
	}

	environment {
		SHARE_FOLDER = "/home/jenkins/flutter-build"
	}
	
	triggers {
		githubPush()
	}

	stages {
		stage('Git clone') {
			steps {
				git branch: 'main', url: 'git@github.com:hovanvydut/pbl6-mobile.git/', credentialsId: 'HOME_SERVER_SSH_PRIVATE_KEY'
			}
		}

		stage('Build') {
			steps {
				sh '''
					flutter build apk --flavor production --target lib/main_production.dart --target-platform android-arm64
					mkdir -p ${SHARE_FOLDER}
					cp -ri ./build/app/outputs/flutter-apk/ ${SHARE_FOLDER}
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