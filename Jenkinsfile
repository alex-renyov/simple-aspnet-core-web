pipeline {
    agent {
        docker { image 'mcr.microsoft.com/dotnet/core/sdk' }
    }
    environment {
        DOTNET_CLI_HOME = "/tmp/DOTNET_CLI_HOME"
    }
    stages {
        stage('Test') {
            steps {
                sh 'dotnet publish MySimpleWebApp/MySimpleWebApp.csproj --configuration Release --verbosity detailed --output ./app'
            }
        }
    }
}