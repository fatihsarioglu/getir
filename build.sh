#!/usr/bin/env bash
 
## shell options
set -e
set -u
set -f
 
## magic variables
declare REPONAME
declare ECR
declare REGION
declare -r -i SUCCESS=0
declare -r -i NO_ARGS=85
declare -r -i BAD_ARGS=86
declare -r -i MISSING_ARGS=87
 
## script functions
function usage() {
  local FILE_NAME
 
  FILE_NAME=$(basename "$0")
 
  printf "Usage: %s [options...]\n" "$FILE_NAME"
  printf " -h\tprint help\n"
  printf " -n\tset ecr repository name\n"
  printf " -e\tset ecr repository uri\n"
  printf " -r\tset aws region\n"
}
 
function no_args() {
  printf "Error: No arguments were passed\n"
  usage
  exit "$NO_ARGS"
}
 
function bad_args() {
  printf "Error: Wrong arguments supplied\n"
  usage
  exit "$BAD_ARGS"
}
 
function missing_args() {
  printf "Error: Missing argument for: %s\n" "$1"
  usage
  exit "$MISSING_ARGS"
}
 
## check script arguments
while getopts "hn:e:r:" OPTION; do
  case "$OPTION" in
    h) usage
       exit "$SUCCESS";;
    n) REPONAME="$OPTARG";;
    e) ECR="$OPTARG";;
    r) REGION="$OPTARG";;
    *) bad_args;;
  esac
done
 
if [ "$OPTIND" -eq 1 ]; then
  no_args
fi
 
if [ -z "$REPONAME" ]; then
  missing_args '-n'
fi
 
if [ -z "$ECR" ]; then
  missing_args '-e'
fi
 
if [ -z "$REGION" ]; then
  missing_args '-r'
fi
 

## run main function
function main() {
  local LAST_ID
 
  # delete all previous image(s)
  LAST_ID=$(docker images -q "$REPONAME")
  if [ -n "$LAST_ID" ]; then
    docker rmi -f "$LAST_ID"
  fi
 
  # build new image
  docker build -t "$REPONAME:" --pull=true .
 
  # tag image for AWS ECR
  docker tag "$REPONAME:" "$ECR":
 
  # basic auth into ECR
  $(aws ecr get-login --no-include-email --region "$REGION")
 
  # push image to AWS ECR
  docker push "$ECR":
}
 
main
 
# exit
exit "$SUCCESS"
