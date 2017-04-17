docker build -t $REPOSITORY_NAME:$DEFAULT_TAG .

docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"

if [[ ! -z $TRAVIS_TAG ]]; then
  docker tag $REPOSITORY_NAME:master $REPOSITORY_NAME:$TRAVIS_TAG
  docker tag $REPOSITORY_NAME:master $REPOSITORY_NAME:latest
fi

docker push $REPOSITORY_NAME

docker logout
