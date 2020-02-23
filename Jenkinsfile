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
                sh 'dotnet publish MySimpleWebApp/MySimpleWebApp.csproj --configuration Release --output ./backend'
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
					docker.withRegistry('limpalex', 'limpalex-docker-com') {
						def customImage = docker.build("simple-web-backend:1.0", "-f Backend.dockerfile .")
					
						customImage.push()
						customImage.push('latest')
					}
				}
			}
		}
		stage('Frontend') {
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

