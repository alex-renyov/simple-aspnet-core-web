pipeline {
    agent none
	stages {
	    stage('Back-end') {
		    agent {
                docker { image 'mcr.microsoft.com/dotnet/core/sdk' }
            }
			environment {
				DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
				DOTNET_CLI_TELEMETRY_OPTOUT = "true"
			}
			steps {
                sh 'dotnet publish MySimpleWebApp/MySimpleWebApp.csproj --configuration Release --output ./app'
            }
			post {
                always {
                    archiveArtifacts artifacts: 'app/**/*'
                }
            }
		}
		stage('Front-end') {
		    agent {
			    docker { image 'node:lts' }
			}
			steps {
			    dir("${env.WORKSPACE}/MySimpleWebApp/ClientApp"){
					sh "npm install"
					sh "npm build"
				}
			}
		}
	}
}
