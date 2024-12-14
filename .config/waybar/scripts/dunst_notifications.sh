#!/bin/bash

# Fetch notifications from dunst
NOTIFICATIONS=$(dunstctl history | jq -r '.data[0] | .[] | "\(.appname): \(.summary) - \(.body)"')

# Limit to the last 3 notifications
NOTIFICATIONS=$(echo "$NOTIFICATIONS" | tail -n 3)

# Check if there are any notifications
if [[ -z "$NOTIFICATIONS" ]]; then
  echo "No notifications"
else
  echo "$NOTIFICATIONS"
fi
