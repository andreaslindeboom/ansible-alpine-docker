#!/bin/bash
set -e

echo "Attempting to run ansible --version inside a container based on the built image"
docker run -it $REPOSITORY_NAME:$DEFAULT_TAG ansible --version
