#!/bin/bash
SLACK_WEBHOOK_URL=$1
echo "The secret is: $SLACK_WEBHOOK_URL"
JOB_NAME=$2
CUSTOM_MESSAGE=$3
Notify_slack=$4
MESSAGE="Job \`${JOB_NAME}\`: ${CUSTOM_MESSAGE}"
if [[ "$Notify_slack" =~ ^[0-9]+$ && "$Notify_slack" -eq 1 ]]; then
  echo "Sending Slack notification..."
  curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" $SLACK_WEBHOOK_URL
else
  echo "Slack notification is disabled (Notify_slack = $Notify_slack)."
fi