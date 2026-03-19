#!/bin/bash
set -e

EC2_HOST=$1
DOCKER_USER=$2
IMAGE_NAME=$3
SSH_KEY="/home/ubuntu/devops-build/build/ubuntu-ssh.pem"
CONTAINER_NAME="react-app"

if [ -z "$EC2_HOST" ] || [ -z "$DOCKER_USER" ] || [ -z "$IMAGE_NAME" ]; then
  echo "Usage: ./deploy.sh <ec2-host> <docker-user> <image-name>"
  exit 1
fi

echo "🚀 Deploying to $EC2_HOST"

ssh -i "$SSH_KEY" -o StrictHostKeyChecking=no ubuntu@$EC2_HOST << EOF
  set -e

  export DOCKER_PASS="$DOCKER_PASS"
  export DOCKER_USER="$DOCKER_USER"

  echo "🔐 Logging into Docker Hub..."
  echo "\$DOCKER_PASS" | docker login -u "\$DOCKER_USER" --password-stdin

  echo "📥 Pulling latest image..."
  docker pull "$IMAGE_NAME"

  echo "🛑 Stopping old container..."
  docker stop $CONTAINER_NAME || true
  docker rm $CONTAINER_NAME || true

  echo "🚀 Starting new container..."
  docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME

  echo "🧹 Cleaning unused images..."
  docker image prune -f || true
EOF

echo "✅ Deployment complete"
