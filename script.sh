#!/bin/bash
SLACK_WEBHOOK_URL=$1
JOB_NAME=$2
MESSAGE="Job \`${JOB_NAME}\` started"
echo "${message}"
curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" $SLACK_WEBHOOK_URL
# Accept the Slack Webhook URL as the first parameter


# Accept the GitHub job name as the second parameter


# Slack message


# Send message to Slack

