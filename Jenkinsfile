#!/usr/bin/env groovy

pipeline {
  agent any
  parameters {
    string(name: 'REPONAME', defaultValue: 'getir/jobapp', description: 'AWS ECR Repository Name')
    string(name: 'ECR', defaultValue: '791943130538.dkr.ecr.eu-central-1.amazonaws.com/getir/jobapp', description: 'AWS ECR Registry URI')
    string(name: 'REGION', defaultValue: 'eu-central-1', description: 'AWS Region code')
    string(name: 'CLUSTER', defaultValue: 'GetirCLuster', description: 'AWS ECS Cluster name')
    string(name: 'TASK', defaultValue: 'ExampleTask', description: 'AWS ECS Task name')
  }
  stages {
    stage('BuildStage') {
      steps {
        sh "bash ./build.sh -b ${env.BUILD_ID} -n ${params.REPONAME} -e ${params.ECR} -r ${params.REGION}"
      }
    }
    stage('DeployStage') {
      steps {
        sh "bash ./deploy.sh -b ${env.BUILD_ID} -e ${params.ECR} -c ${params.CLUSTER} -t ${params.TASK}"
      }
    }
    stage('TestStage') {
      steps {
        sh "bash ./test.sh"
      }
    }
  }
}
