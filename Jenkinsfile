pipeline {
    agent any

    environment {
        AZURE_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
        AZURE_CLIENT_ID       = credentials('AZURE_CLIENT_ID')
        AZURE_CLIENT_SECRET   = credentials('AZURE_CLIENT_SECRET')
        AZURE_TENANT_ID       = credentials('AZURE_TENANT_ID')
    }

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
                sh "terraform plan -var 'AZURE_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}' -var 'AZURE_CLIENT_ID=${env.AZURE_CLIENT_ID}' -var 'AZURE_CLIENT_SECRET=${env.AZURE_CLIENT_SECRET}' -var 'AZURE_TENANT_ID=${env.AZURE_TENANT_ID}'"
            }
        }

        stage("Action") {
            steps {
                sh "terraform ${action} --auto-approve -var 'AZURE_SUBSCRIPTION_ID=${env.AZURE_SUBSCRIPTION_ID}' -var 'AZURE_CLIENT_ID=${env.AZURE_CLIENT_ID}' -var 'AZURE_CLIENT_SECRET=${env.AZURE_CLIENT_SECRET}' -var 'AZURE_TENANT_ID=${env.AZURE_TENANT_ID}'"
            }
        }

        stage("Deploy to AKS") {
            when {
                expression { params.action == 'apply' }
            }
            steps {
                // Update kubeconfig for AKS cluster
                sh "az aks get-credentials --name gfakxaks --resource-group gfakxrg"
                sh "kubectl apply -f deployment.yml"
            }
        }
    }
}
