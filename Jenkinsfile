#!groovy

pipeline {
    agent {
        label 'docker'
    }

    options {
        buildDiscarder(logRotator(daysToKeepStr:'15'))
    }

    parameters {
        string(name: 'epitest_docker_tag', description: 'Tag of the epitest-docker image (ignored on release)', defaultValue: 'devel')
		booleanParam(name: 'NOCACHE', description: 'Skip cache (ignored on release)', defaultValue: false)
        booleanParam(name: 'RELEASE', description: 'Release this docker image (epitest_docker_tag will be ignored and replaces by latest', defaultValue: false)
    }

    stages {
        stage('Build') {
            when {
                not {
                    expression {
                        return params.RELEASE
                    }
                }
            }
            steps {
                ansiColor('xterm') {
                    sh "./build.sh --tag ${params.epitest_docker_tag} ${params.NOCACHE ? "-n" : ""}"
                }
            }
        }
        stage('Build Release') {
            when {
                expression {
                    return params.RELEASE
                }
            }
            steps {
                ansiColor('xterm') {
                    sh "./build.sh --tag latest"
                }
            }
        }
        stage('Archive') {
            when {
                not {
                    expression {
                        return params.RELEASE
                    }
                }
            }
            steps {
                ansiColor('xterm') {
                    script {
                        docker.withRegistry('https://nexus.epitest.eu:9081/', 'nexus-epitest-ci') {
                            sh "docker tag epitechcontent/epitest-docker:${params.epitest_docker_tag} nexus.epitest.eu:9081/epitechcontent/epitest-docker:${params.epitest_docker_tag}  && docker push nexus.epitest.eu:9081/epitechcontent/epitest-docker:${params.epitest_docker_tag}"
                        }
                        docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-login') {
                            sh "docker push epitechcontent/epitest-docker:${params.epitest_docker_tag}"
                        }
                    }
                }
            }
        }
        stage('Release') {
            when {
                expression {
                    return params.RELEASE
                }
            }
            steps {
                ansiColor('xterm') {
                    script {
                        docker.withRegistry('https://nexus.epitest.eu:9081/', 'nexus-epitest-ci') {
                            sh "docker tag epitechcontent/epitest-docker:latest nexus.epitest.eu:9081/epitechcontent/epitest-docker:latest && docker push nexus.epitest.eu:9081/epitechcontent/epitest-docker:latest"
                        }
                        docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-login') {
                            sh "docker push epitechcontent/epitest-docker:latest"                        
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            withCredentials([string(credentialsId: 'teams-webhook', variable: 'TEAMS_WEBHOOK')]) {
                script {
                    office365ConnectorSend message: "Build Success for $JOB_NAME#$BUILD_ID", status:"Success", webhookUrl:"$TEAMS_WEBHOOK"
                }
            }
        }
        failure {
            withCredentials([string(credentialsId: 'teams-webhook', variable: 'TEAMS_WEBHOOK')]) {
                script {
                    office365ConnectorSend message: "Build Failure for $JOB_NAME#$BUILD_ID", status:"Failure", webhookUrl:"$TEAMS_WEBHOOK"
                }
            }
        }
        always {
            deleteDir()
        }
    }
}
