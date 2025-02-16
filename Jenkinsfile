pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = credentials('AWS_ACCESS')  // Using AWS credentials from Jenkins
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/Satyamtripathi1996/terraform-aws-infra.git'
            }
        }

        stage('Setup Terraform') {
            steps {
                sh 'terraform --version'
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (env.BRANCH_NAME == "satyam") {
                        sh 'terraform plan -out=tfplan'
                    } else if (env.BRANCH_NAME == "hyder") {
                        sh 'terraform plan -destroy -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply/Destroy') {
            steps {
                script {
                    if (env.BRANCH_NAME == "satyam") {
                        sh 'terraform apply -auto-approve'
                    } else if (env.BRANCH_NAME == "hyder") {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Terraform job finished."
        }
    }
}
