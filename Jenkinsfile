pipeline{
	agent {
		node {
			label 'jenkins_slave_1'
		}
	}
	
	triggers {
		githubPush()
	}
	
	environment {
		REMOTE_SERVER_DOMAIN = 'jenkins-slave-1.silk-cat.software'
	}

	stages {
		stage('Git clone') {
			steps {
				git branch: 'main', url: 'https://github.com/hovanvydut/pbl6-mobile.git'
			}
		}

		stage('SSH remote server') {
			steps {
				script {
					sshagent(credentials: ['droplet_1_private_key']) {
						sh '''
							ssh -o StrictHostKeyChecking=no -l root $REMOTE_SERVER_DOMAIN uname -a &&
                            flutter build apk --flavor production -t lib/main_production.dart
						'''
					}
				}
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