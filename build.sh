#!/bin/bash

# Build Docker image
docker build -t $DOCKERHUB_USER/react-app:latest .

# Optional: tag image again
docker tag $DOCKERHUB_USER/react-app:latest $DOCKERHUB_USER/react-app:latest

# Login to Docker Hub using credentials from Jenkins
echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin

# Push image
docker push $DOCKERHUB_USER/react-app:latest
