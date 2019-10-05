#!/usr/bin/env groovy

pipeline {
  agent any
  parameters {
    string(name: 'REPONAME', defaultValue: 'getir/jobapp', description: 'AWS ECR Repository Name')
    string(name: 'ECR', defaultValue: '791943130538.dkr.ecr.eu-central-1.amazonaws.com/getir/jobapp:latest', description: 'AWS ECR Registry URI')
    string(name: 'REGION', defaultValue: 'eu-central-1', description: 'AWS Region code')
    string(name: 'CLUSTER', defaultValue: 'GetirCluster', description: 'AWS ECS Cluster name')
    string(name: 'TASK', defaultValue: 'GetirTask', description: 'AWS ECS Task name')
  }
  stages {
    stage('BuildStage') {
      steps {
        sh "./build.sh -b ${env.BUILD_ID} -n ${params.REPONAME} -e ${params.ECR} -r ${params.REGION}"
      }
    }
    stage('DeployStage') {
      steps {
        sh "./deploy.sh"
      }
    }
    stage('TestStage') {
      steps {
        sh "./test.sh"
      }
    }
  }
}
