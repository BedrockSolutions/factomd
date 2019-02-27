#!/usr/bin/env bash

NAMESPACE='bedrocksolutions'
IMAGE_NAME='factomd'
TAG='latest'

docker push ${NAMESPACE}/${IMAGE_NAME}:${TAG}
