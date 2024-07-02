def appName = 'new-deploy'
def namespace = 'default'


pipeline {

agent any
 stages {
     stage("Checkout code") {
         steps {
             checkout scm
         }
     }
     stage('Git clone') {
      steps {
        git branch: 'main', credentialsId: 'usnmepswdGIT',
          url: 'https://github.com/SATRIAGED/new-deploy.git'
      }
    }
     stage("building the image") {
            steps {
                script {
                    sh "docker build -t new-deploy/nginx:latest ."
                    sh "docker images"
                    // sh "docker run -d -p 81:80 new-deploy/nginx:latest"
                }
            }
        }

        // stage("installing the helm chart") {
        //     steps {
        //         withCredentials([vaultString(credentialsId: 'kubeconfig', variable: '')]) {
        //             sh("gcloud container clusters kubeconfig ${params.GKE_CLUSTER_NAME} --zone ${params.GCP_PROJECT_ZONE} --project ${params.GCP_PROJECT_ID}")
        //             sh "helm install \
        //                     --set image.repository=gcr.io/${params.GCP_PROJECT_ID}/${params.GCR_IMAGE_NAME} \
        //                     --set image.tag=${params.GCR_IMAGE_TAG} \
        //                 new-helm new-deploy"
        //             sh "sleep 45s"
        //             sh "kubectl get svc --namespace default new-helm-new-deploy"
        //         }
        //     }
        // }

 stage("Deploy Kubernetes") {
    // when {
    //   branch 'main'
    // }
     steps {
    //   withKubeConfig(caCertificate: '', clusterName: 'kubernetes', contextName: '', credentialsId: 'kubeconfig', namespace: 'default', restrictKubeConfigAccess: false, serverUrl: 'https://192.168.0.26:6443', variable: 'KUBECONFIG') {
    withCredentials([file(credentialsId: "kubeconfig", variable: "KUBECONFIG")]) {
      // sh 'kubectl apply -f deployment.yaml'
      // sh 'kubectl apply -f service.yaml'
      sh 'mkdir -p ~/.kube/'
      sh 'cat ${KUBECONFIG} >> ~/.kube/config'
      sh "helm install \
              --set image.repository=localhost:5000/new-deploy \
              --set image.tag=latest \
              -f ./new-deploy/values.yaml --debug --namespace default \
          new-deploy --generate-name"
      
    // some block
      }
      // withKubeConfig([credentialsId: 'kubeconfig']) {
      //     sh 'cat deployment.yaml | sed "s/{{BUILD_NUMBER}}/$BUILD_NUMBER/g" | kubectl apply -f -'
      //     sh 'kubectl apply -f service.yaml'
      //   }
        // kubernetesDeploy(
        //   kubeconfigId: 'kubeconfig',
        //   configs: 'deployment.yaml',
        //   enableConfigSubstitution: true
        // )
        // kubernetesDeploy(
        //   kubeconfigId: 'kubeconfig',
        //   configs: 'service.yaml',
        //   enableConfigSubstitution: true
        // )
        // kubeconfig(caCertificate: 'kubecertif', credentialsId: 'kubeconfig', serverUrl: 'https://192.168.0.26:6443') {
        //   sh "kubectl apply -f deployment.yaml"
        //   sh "kubectl apply -f service.yaml"
          // kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
        //}
      //    {
      //  sh "kubectl apply -f deployment.yaml"
      //  sh "kubectl apply -f service.yaml"
      //  }                
       //kubernetesDeploy(configs: "deployment.yml", "service.yml")
       }                
     }

   }
 }

