pipeline {
    agent {
        docker { image 'mcr.microsoft.com/dotnet/core/sdk' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'dotnet publish MySimpleWebApp\MySimpleWebApp.csproj --configuration Release --verbosity detailed --output ./app'
            }
        }
    }
}