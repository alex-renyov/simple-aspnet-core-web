pipeline {
    agent none
	stages {
	    stage('Backend') {
		    agent {
                docker { image 'mcr.microsoft.com/dotnet/core/sdk' }
            }
			environment {
				DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
				DOTNET_CLI_TELEMETRY_OPTOUT = "true"
			}
			steps {
				script {
					def branch = env.GIT_BRANCH.substring("release/".size())
					def version = branch + ".0." + env.BUILD_NUMBER
					sh "dotnet publish MySimpleWebApp/MySimpleWebApp.csproj --configuration Release --output ./backend /p:InformationalVersion=$version /p:FileVersion=$version /p:AssemblyVersion=$version /p:Version=$version"
				}
				stash name: 'backend', includes: 'backend/**/*'
            }
			post {
                always {
                    archiveArtifacts artifacts: 'backend/**/*'
                }
            }
		}
		stage('Backend-Docker') {
			agent any
			environment {
				registry = "limpalex/simple-web-backend"
                registryCredential = "limpalex-docker-com"

			}
			steps {
			    unstash name: 'backend'
				script {
				    def branch = env.GIT_BRANCH.substring("release/".size())
					def customImage = docker.build("limpalex/simple-web-backend:$branch", "-f Backend.dockerfile .")
					docker.withRegistry('', 'limpalex-docker-com') {
						customImage.push()
					}
				}
			}
		}
	}
}

