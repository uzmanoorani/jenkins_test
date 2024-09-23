#!/bin/bash
SLACK_WEBHOOK_URL=$1
JOB_NAME=$2
CUSTOM_MESSAGE=$3
MESSAGE="Job \`${JOB_NAME}\`: ${CUSTOM_MESSAGE}"
echo "${message}"
curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" $SLACK_WEBHOOK_URL
