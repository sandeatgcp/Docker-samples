node {
  def project = 'myjenkinspro'
  def appName = 'apache-app'
  def feSvcName = "my${appName}"
  def imageTag = "gcr.io/${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
  // def check = sh("kubectl get deployment --namespace jenkins|grep myapache-app|awk '{print $1}'")

  checkout scm

  stage 'Build image'
  sh("docker build -t ${imageTag} .")

  stage 'Run Go tests'
  sh("docker images")

  stage 'Push image to registry'
  sh("gcloud docker -- push ${imageTag}")

  stage ('Deploy Application') {
  check = sh("kubectl get deployment --namespace jenkins|grep myapache-app|awk '{print $1}'")
    script {
        if (check == ${feSvcName}) {
        sh("kubectl set image deployment/${feSvcName} ${feSvcName}=${imageTag}")
	echo 'Successfully updated the deployment'
           } else {
    sh("kubectl run  ${feSvcName} --image=${imageTag} --port 80") 
    sh("kubectl expose deployment ${feSvcName} --type=LoadBalancer --port=8080 --target-port=80")
    echo 'To access your environment run `kubectl get svc`'
      }
  }
  }
