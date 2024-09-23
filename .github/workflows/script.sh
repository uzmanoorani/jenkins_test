#!/bin/bash

# Accept the Slack Webhook URL as the first parameter
#SLACK_WEBHOOK_URL=$1

# Accept the GitHub job name as the second parameter
JOB_NAME=$1

# Slack message
MESSAGE="Job \`${JOB_NAME}\` started"

# Send message to Slack
#curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" $SLACK_WEBHOOK_URL
