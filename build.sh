#!/bin/bash

# set -xe

if [[ -z "${DOCKER_USERNAME}" ]]; then
    DOCKER_USERNAME=caeret
fi

IMAGE_NAME="nginx-php-docker"

docker build -t "${DOCKER_USERNAME}/${IMAGE_NAME}:latest" .

if [[ -n "${DOCKER_PASSWORD}" ]]; then
    echo "Publish image '${DOCKER_USERNAME}/${IMAGE_NAME}:latest' to Docker Hub ..."

    docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"

    docker push "${DOCKER_USERNAME}/${IMAGE_NAME}:latest"
fi