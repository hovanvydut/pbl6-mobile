pipeline {
  agent {
    node {
      label 'agentflutter'
    }

  }
  stages {
    stage('Git clone') {
      steps {
        git(branch: 'main', url: 'git@github.com:hovanvydut/pbl6-mobile.git/', credentialsId: 'HOME_SERVER_SSH_PRIVATE_KEY')
      }
    }

    stage('Build') {
      steps {
        sh '''
					flutter build apk --flavor production --target lib/main_production.dart --target-platform android-arm64
					mkdir -p ${SHARE_FOLDER}
					
				'''
      }
    }

    stage('Publish') {
      steps {
        sh '''cp -r ./build/app/outputs/flutter-apk/ ${SHARE_FOLDER}

tag=$(git describe --tags)
message="$(git for-each-ref refs/tags/$tag --format=\'%(contents)\')"
name=$(echo "$message" | head -n1)
description=$(echo "$message" | tail -n +3)
description=$(echo "$description" | sed -z \'s/\\n/\\\\n/g\')

release=$(curl -XPOST -H "Authorization:token $token" --data "{\\"tag_name\\": \\"$tag\\", \\"target_commitish\\": \\"master\\", \\"name\\": \\"$name\\", \\"body\\": \\"$description\\", \\"draft\\": false, \\"prerelease\\": true}" https://api.github.com/repos/hovanvydut/pbl6-mobile/releases)

token="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"
id=$(echo "$release" | sed -n -e \'s/"id":\\ \\([0-9]\\+\\),/\\1/p\' | head -n 1 | sed \'s/[[:blank:]]//g\')
curl -XPOST -H "Authorization:token $token" -H "Content-Type:application/octet-stream" --data-binary @artifact.zip https://uploads.github.com/repos/hovanvydut/pbl6-mobile/releases/$id/assets?name=artifact.zip
'''
      }
    }

  }
  environment {
    SHARE_FOLDER = '/home/jenkins/flutter-build'
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

    aborted {
      echo 'Aborted message'
    }

  }
  triggers {
    githubPush()
  }
}