#!/bin/bash
set -e

echo "Build image ($REPOSITORY_NAME:$DEFAULT_TAG)"
docker build -t $REPOSITORY_NAME:$DEFAULT_TAG .

echo "Attempting to run ansible --version inside a container based on the built image"
docker run -it $REPOSITORY_NAME:$DEFAULT_TAG ansible --version

echo "Log in on Docker Hub with user $DOCKER_USERNAME"
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"

if [[ ! -z $TRAVIS_TAG ]]; then
  echo "Release found with Git tag $TRAVIS_TAG"
  echo "Tagging image with Git tag: $REPOSITORY_NAME:$TRAVIS_TAG"
  docker tag $REPOSITORY_NAME:$DEFAULT_TAG $REPOSITORY_NAME:$TRAVIS_TAG

  echo "Tagging image with Ansible version: $REPOSITORY_NAME:$ANSIBLE_VERSION-latest"
  docker tag $REPOSITORY_NAME:$DEFAULT_TAG $REPOSITORY_NAME:$ANSIBLE_VERSION

  echo "Tagging image as latest: $REPOSITORY_NAME:latest"
  docker tag $REPOSITORY_NAME:$DEFAULT_TAG $REPOSITORY_NAME:latest
fi

echo "Push repository $REPOSITORY_NAME"
docker push $REPOSITORY_NAME

echo "Log out on Docker Hub"
docker logout
