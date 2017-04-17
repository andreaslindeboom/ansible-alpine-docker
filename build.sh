#!/bin/bash
set -e

echo "Build image"
docker build -t $REPOSITORY_NAME:$DEFAULT_TAG .

echo "Log in on Docker Hub with user $DOCKER_USERNAME"
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"

if [[ ! -z $TRAVIS_TAG ]]; then
  echo "Tag found, tagging image"
  docker tag $REPOSITORY_NAME:master $REPOSITORY_NAME:$TRAVIS_TAG
  docker tag $REPOSITORY_NAME:master $REPOSITORY_NAME:latest
fi

echo "Push repoitory"
docker push $REPOSITORY_NAME

echo "Log out on Docker Hub"
docker logout
