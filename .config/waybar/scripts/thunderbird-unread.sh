#!/bin/bash

# Try different methods to get unread count
UNREAD=0

# Method 1: Check global unread count
if which thunderbird-unread &>/dev/null; then
    UNREAD=$(thunderbird-unread)
# Method 2: Check local inbox (may not work with IMAP)
elif [ -d ~/.thunderbird ]; then
    INBOX=$(find ~/.thunderbird -path '*Inbox' -type d | head -1)
    if [ -n "$INBOX" ]; then
        UNREAD=$(find "$INBOX" -type f | grep -v ',S' | wc -l)
    fi
fi

# Output JSON for Waybar
echo "{\"text\":\"$UNREAD\", \"alt\":\" $UNREAD\", \"tooltip\":\"$UNREAD unread messages\"}"
