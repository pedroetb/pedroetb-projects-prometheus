#!/bin/sh

imageName=${PROMTOOL_IMAGE_NAME:-prom/prometheus}
imageTag=${PROMTOOL_IMAGE_TAG:-latest}

rulesPath=${PROMTOOL_RULES_PATH:-deploy/rules}
rulesFiles="$(cd ${rulesPath} && ls *.yml)"

docker run --rm -q \
	-v "$(pwd)/${rulesPath}:/mnt" \
	-w "/mnt" \
	--entrypoint "promtool" \
	"${imageName}:${imageTag}" \
		check rules ${rulesFiles}
