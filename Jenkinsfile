pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/gfakx/infra-jenkins-terraform-azure.git'
            }
        }

        stage("terraform init") {
            steps {
                sh "terraform init"
            }
        }

        stage("plan") {
            steps {
                withCredentials([
                    string(credentialsId: 'AZURE_SUBSCRIPTION_ID', variable: 'AZURE_SUBSCRIPTION_ID'),
                    string(credentialsId: 'AZURE_CLIENT_ID', variable: 'AZURE_CLIENT_ID'),
                    string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'AZURE_CLIENT_SECRET'),
                    string(credentialsId: 'AZURE_TENANT_ID', variable: 'AZURE_TENANT_ID')
                ]) {
                    sh "terraform plan -var 'AZURE_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}' -var 'AZURE_CLIENT_ID=${env.AZURE_CLIENT_ID}' -var 'AZURE_CLIENT_SECRET=${env.AZURE_CLIENT_SECRET}' -var 'AZURE_TENANT_ID=${env.AZURE_TENANT_ID}'"
                }
            }
        }

        stage("Action") {
            steps {
                withCredentials([
                    string(credentialsId: 'AZURE_SUBSCRIPTION_ID', variable: 'AZURE_SUBSCRIPTION_ID'),
                    string(credentialsId: 'AZURE_CLIENT_ID', variable: 'AZURE_CLIENT_ID'),
                    string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'AZURE_CLIENT_SECRET'),
                    string(credentialsId: 'AZURE_TENANT_ID', variable: 'AZURE_TENANT_ID')
                ]) {
                    sh "terraform ${action} --auto-approve -var 'AZURE_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}' -var 'AZURE_CLIENT_ID=${env.AZURE_CLIENT_ID}' -var 'AZURE_CLIENT_SECRET=${env.AZURE_CLIENT_SECRET}' -var 'AZURE_TENANT_ID=${env.AZURE_TENANT_ID}'"
                }
            }
        }

        stage("Deploy to AKS") {
            when {
                expression { params.action == 'apply' }
            }
            steps {
                withCredentials([
                    string(credentialsId: 'AZURE_SUBSCRIPTION_ID', variable: 'AZURE_SUBSCRIPTION_ID'),
                    string(credentialsId: 'AZURE_CLIENT_ID', variable: 'AZURE_CLIENT_ID'),
                    string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'AZURE_CLIENT_SECRET'),
                    string(credentialsId: 'AZURE_TENANT_ID', variable: 'AZURE_TENANT_ID')
                ]) {
                    sh "az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID"
                    sh "az aks get-credentials --name gfakxaks --resource-group gfakxrg"
                    sh "kubectl apply -f deployment.yml"
                }
            }
        }
    }
}
