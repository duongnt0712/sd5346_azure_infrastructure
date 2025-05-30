// Jenkins CI Pipeline - Build & Push Docker Image to ECR
pipeline {
  agent any

  environment {
    AWS_REGION        = 'ap-southeast-1'
    EKS_CLUSTER_NAME  = 'practical-devops-eks'
  }

  stages {
    stage('Checkout K8s Manifests') {
      steps {
        checkout scm
      }
    }

    stage('Deploy to EKS') {
      steps {
        sh '''
          aws eks update-kubeconfig --region $AWS_REGION --name $EKS_CLUSTER_NAME
          kubectl apply -f kubernetes/mongodb.yaml
          kubectl apply -f kubernetes/backend.yaml
          kubectl apply -f kubernetes/frontend.yaml
        '''
      }
    }
  }

  post {
    success {
      echo 'Pipeline Succeeded!'
    }
    failure {
      echo 'Pipeline Failed!'
    }
  }
}