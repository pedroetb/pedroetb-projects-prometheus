#!/bin/sh

DOCKER_IMAGE_NAME=${DOCKER_IMAGE_NAME:-dnanexus/promtool}
DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG:-2.9.2}

rulesPath=$(pwd)/deploy/config/rules

for f in ${rulesPath}/*.rules.yml
do
	if [ -e "${f}" ]
	then
		filename=$(basename "${f}")
		docker run \
			--name prometheus-rule-tester \
			-v ${rulesPath}:/tmp \
			--rm \
			${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} \
			check rules /tmp/${filename}
	fi
done
