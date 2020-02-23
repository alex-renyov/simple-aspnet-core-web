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
				registry = "limpalex/simple-web-backend"
                registryCredential = "limpalex-docker-com"
			}
			steps {
                sh 'dotnet publish MySimpleWebApp/MySimpleWebApp.csproj --configuration Release --output ./backend'
				def customImage = docker.build("my-simple-web-app:1.0", "-f ${dockerfile} ./docker-backend")
				def dockerfile = 'Backend.dockerfile'
				customImage.push()
				customImage.push('latest')

            }
			post {
                always {
                    archiveArtifacts artifacts: 'backend/**/*'
					archiveArtifacts artifacts: 'docker-backend/*'
                }
            }
		}
		stage('Front-end') {
		    agent {
			    docker { image 'node:lts' }
			}
			steps {
			    dir("${env.WORKSPACE}/MySimpleWebApp/ClientApp") {
					sh "npm install"
					sh "npm run build"
					sh "mkdir ../../frontend"
					sh "cp -r build/* ../../frontend"
				}
			}
			post {
			    always {
    		        archiveArtifacts artifacts: 'frontend/**/*'
				}
			}
		}
	}
}

