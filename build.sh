#!/bin/bash
set -e

echo "Build image ($REPOSITORY_NAME:$DEFAULT_TAG)"
docker build -t $REPOSITORY_NAME:$DEFAULT_TAG .

echo "Log in on Docker Hub with user $DOCKER_USERNAME"
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"

if [[ ! -z $TRAVIS_TAG ]]; then
  echo "Tag found, tagging image ($REPOSITORY_NAME:$TRAVIS_TAG)"
  docker tag $REPOSITORY_NAME:master $REPOSITORY_NAME:$TRAVIS_TAG
  echo "Tag found, tagging image ($REPOSITORY_NAME:latest)"
  docker tag $REPOSITORY_NAME:master $REPOSITORY_NAME:latest
fi

echo "Push repository $REPOSITORY_NAME"
docker push $REPOSITORY_NAME

echo "Log out on Docker Hub"
docker logout
