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
            }
			post {
                always {
                    archiveArtifacts artifacts: 'backend/**/*'
					archiveArtifacts artifacts: 'docker-backend/*'
                }
            }
		}
		stage('Backend-Docker') {
			environment {
				registry = "limpalex/simple-web-backend"
                registryCredential = "limpalex-docker-com"

			}
			steps {
				script {
					def dockerfile = 'Backend.dockerfile'
					def customImage = docker.build(registry + ":1.0", "-f ${dockerfile} ./docker-backend")
				
					customImage.push()
					customImage.push('latest')
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

