pipeline {
    agent {
        docker { image 'mcr.microsoft.com/dotnet/core/sdk' }
    }
    environment {
        DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
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
            archiveArtifacts artifacts: 'app/**/*', fingerprint: true
        }
    }
}