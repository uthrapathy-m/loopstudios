pipeline {
  agent any

  environment {
    IMAGE = "uthrapathyofc/tailwind-site"
    TAG = "latest"
  }

  tools {
    nodejs 'node16'
  }

  stages {
    stage('Clone') {
      steps {
       git branch: 'main', url: 'https://github.com/uthrapathy-m/loopstudios.git'
      }
    }

    stage('Install & Build Tailwind') {
      steps {
        sh 'npm install'
        sh 'npm run watch'
      }
    }

    stage('Docker Build') {
      steps {
        sh "docker build -t $IMAGE:$TAG ."
      }
    }

    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
          sh "docker push $IMAGE:$TAG"
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f k8s/deployment.yaml'
        sh 'kubectl apply -f k8s/service.yaml'
        sleep 40
      }
    }

    stage('Endpoints') {
      steps {
        sh 'kubectl get pods'
        sh 'kubectl get svc'
        sh 'minikube service tailwind-service --url'
      }
    }
  }
}
