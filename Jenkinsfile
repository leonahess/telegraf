pipeline {
  agent any
  triggers {
    pollSCM('H/15 * * * *')
  }
  stages {
    stage('Build Comtainer') {
      parallel {
        stage('Build ARM') {
          agent {
            label "Pi_3"
          }
          steps {
            sh "docker build -t telegraf ."
          }
        }
        stage('Build amd64') {
          agent {
            label "master"
          }
          steps {
            sh "docker build -t telegraf ."
          }
        }
      }
    }
    stage('Tag Container') {
      parallel {
        stage('Tag ARM') {
          agent {
            label "Pi_3"
          }
          steps {
            sh "docker tag telegraf fx8350:5000/telegraf:arm"
            sh "docker tag telegraf leonhess/telegraf:arm"
          }
        }
        stage('Tag amd64') {
          agent {
            label "master"
          }
          steps {
            sh "docker tag telegraf fx8350:5000/telegraf:amd64"
            sh "docker tag telegraf leonhess/telegraf:amd64"
          }
        }
      }
    }
    stage('Push to Registries') {
      parallel {
        stage('Push ARM to local Registry') {
          agent {
            label "Pi_3"
          }
          steps {
            sh "docker push fx8350:5000/telegraf:arm"
          }
        }
        stage('Push ARM to DockerHub') {
          agent {
            label "Pi_3"
          }
          steps {
            withDockerRegistry([credentialsId: "dockerhub", url: ""]) {
              sh "docker push leonhess/telegraf:arm"
            }
          }
        }
        stage('Push amd64 to local Registry') {
          agent {
            label "master"
          }
          steps {
            sh "docker push fx8350:5000/telegraf:amd64"
          }
        }
        stage('Push amd64 to Dockerhub') {
          agent {
            label "master"
          }
          steps {
            withDockerRegistry([credentialsId: "dockerhub", url: ""]) {
              sh "docker push leonhess/telegraf:amd64"
            }
          }
        }
      }
    }
    stage('Cleanup') {
      parallel {
        stage('Cleanup ARM') {
          agent {
            label "Pi_3"
          }
          steps {
            sh "docker rmi fx8350:5000/telegraf:arm"
            sh "docker rmi leonhess/telegraf:arm"
          }
        }
        stage('Cleanup amd64') {
          agent {
            label "master"
          }
          steps {
            sh "docker rmi fx8350:5000/telegraf:amd64"
            sh "docker rmi leonhess/telegraf:amd64"
          }
        }
      }
    }
    stage('Create Manifest') {
      parallel{
        stage('Create DockerHub manifest') {
          agent {
            label "master"
          }
          steps {
            sh "docker manifest create --amend leonhess/telegraf leonhess/telegraf:arm leonhess/telegraf:amd64"
          }
        }
        /*
        stage('Create local Registry manifest') {
        agent {
        label "master"
      }
      steps {
      sh "docker manifest create --amend fx8350:5000/telegraf:latest fx8350:5000/telegraf:arm fx8350:5000/telegraf:amd64"
    }
  }
  */
}
}
stage('Push Manifest') {
  parallel {
    stage('Create DockerHub manifest') {
      agent {
        label "master"
      }
      steps {
        withDockerRegistry([credentialsId: "dockerhub", url: ""]) {
          sh "docker manifest push -p leonhess/telegraf"
        }
      }
    }
    /*
    stage('Create local Registry manifest') {
      agent {
        label "master"
      }
      steps {
        sh "docker manifest push -p fx8350:5000/telegraf:latest"
      }
    }
    */
  }
}
}
}
