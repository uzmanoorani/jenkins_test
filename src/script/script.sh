#!/bin/bash
echo "The secret is: $secret"
SLACK_WEBHOOK_URL=$secret
echo "The secret is: $SLACK_WEBHOOK_URL"
# JOB_NAME=$1
# CUSTOM_MESSAGE=$2
# MESSAGE="Job \`${JOB_NAME}\`: ${CUSTOM_MESSAGE}"
# echo "${message}"

#curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" $SLACK_WEBHOOK_URL
