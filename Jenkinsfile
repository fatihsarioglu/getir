#!/usr/bin/env groovy

pipeline {
   agent {
    label 'master'
    }
    options {
        timestamps()
        retry(1)
        buildDiscarder(logRotator(numToKeepStr: '5'))
        timeout(time: 45, unit: 'SECONDS')
        disableConcurrentBuilds()
    }

    environment {
        AWS_ACCESS_KEY_ID= credentials('getir-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY= credentials('getir-aws-secret-access-key')
        AWS_DEFAULT_REGION='eu-central-1'    
    }
    stages {
        stage('Deploy to ECS') {

                steps {
        sh "./deploy.sh"
    }
                      
                    } 
           } 
}
