#!/bin/bash

# build.sh
IMAGE_NAME="project"
TAG=$1  # Pass 'dev' or 'prod' as an argument

# Build the Docker image
docker build -t $IMAGE_NAME .

# Tag the image with the provided tag (dev or prod)
docker tag $IMAGE_NAME ragul11/$TAG:latest
