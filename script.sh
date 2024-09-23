#!/bin/bash

# Slack Webhook URL
SLACK_WEBHOOK_URL="${{ secrets.SLACK_WEBHOOK_URL }}"

# Slack message
JOB_NAME=$1  # Pass the GitHub job name as a parameter when calling the script
MESSAGE="Job \`${JOB_NAME}\` started"

# Send message to Slack
curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" $SLACK_WEBHOOK_URL
