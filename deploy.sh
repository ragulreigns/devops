#!/bin/bash

# deploy.sh
TAG=$1  # Pass 'dev' or 'prod' as an argument

# Log in to Docker Hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Push the image to Docker Hub
docker push ragul11/$TAG:latest
