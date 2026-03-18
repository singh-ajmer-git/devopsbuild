#!/bin/bash
set -e

IMAGE_NAME=react-app
TARGET_REPO=$1
TAG=${2:-latest}

if [ -z "$TARGET_REPO" ]; then
  echo "Target repo missing"
  exit 1
fi

echo "Building image..."
docker build -t $IMAGE_NAME .

echo "Tagging image..."
docker tag $IMAGE_NAME $TARGET_REPO:$TAG

echo "Pushing image..."
docker push $TARGET_REPO:$TAG
