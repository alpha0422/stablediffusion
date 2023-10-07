#!/bin/sh

VERSION=${1:-"23.09"}
FROM_IMAGE="gitlab-master.nvidia.com:5005/dl/dgx/pytorch:${VERSION}-py3-devel"
IMAGE="gitlab-master.nvidia.com:5005/$(id -un)/pytorch:${VERSION}-py3-devel-sai-sdv2"

docker pull ${FROM_IMAGE}
docker build \
    -f Dockerfile \
    --build-arg FROM_IMAGE_NAME=${FROM_IMAGE} \
    -t ${IMAGE} \
    .
docker push ${IMAGE}
