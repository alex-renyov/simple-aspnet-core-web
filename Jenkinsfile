pipeline {
    agent {
        docker { image 'mcr.microsoft.com/dotnet/core/sdk' }
    }
    environment {
        DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
		DOTNET_CLI_TELEMETRY_OPTOUT = "true"
    }
    stages {
        stage('Build') {
            steps {
                sh 'dotnet publish MySimpleWebApp/MySimpleWebApp.csproj --configuration Release --output ./app'
            }
        }
    }
	post {
        always {
            archiveArtifacts artifacts: 'app/**/*'
        }
    }
}
