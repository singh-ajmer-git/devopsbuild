#!/bin/bash

set -e

IMAGE_NAME="$DOCKERHUB_USER/react-app:latest"

docker build -t $IMAGE_NAME .

echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin

docker push $IMAGE_NAME
