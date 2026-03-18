#!/bin/bash

set -e

# Validate input
if [ -z "$ENV" ]; then
  echo "ENV not set (dev/prod)"
  exit 1
fi

# Set repo based on environment
if [ "$ENV" = "dev" ]; then
  IMAGE_NAME="$DOCKERHUB_USER/react-app-dev:latest"
elif [ "$ENV" = "prod" ]; then
  IMAGE_NAME="$DOCKERHUB_USER/react-app-prod:latest"
else
  echo "Invalid ENV value"
  exit 1
fi

echo "Building image: $IMAGE_NAME"

docker build -t $IMAGE_NAME .

echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin

docker push $IMAGE_NAME

echo "Image pushed successfully!"
