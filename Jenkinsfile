node {
  def project = 'myjenkinspro'
  def appName = 'apache-app'
  def feSvcName = "my${appName}"
  def imageTag = "gcr.io/${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

  checkout scm

  stage 'Build image'
  sh("docker build -t ${imageTag} .")

  stage 'Run Go tests'
  sh("docker run ${imageTag} go test")

  stage 'Push image to registry'
  sh("gcloud docker -- push ${imageTag}")

  stage "Deploy Application"
        sh("kubectl run  ${feSvcName} --image=$imagetag --port 80") 
        sh("kubectl expose deployment ${feSvcName} --type=LoadBalancer --port=8080 --target-port=80")
        echo 'To access your environment run `kubectl get svc`'
  }
