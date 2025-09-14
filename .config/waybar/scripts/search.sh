#!/bin/bash

# Example for a web search using a browser
BROWSER="brave"
SEARCH_ENGINE="https://duckduckgo.com/?q="

if [ -n "$1" ]; then
    "$BROWSER" "${SEARCH_ENGINE}$1"
else
    # Prompt for input if no argument is provided
    QUERY=$(echo "" | wofi --dmenu --prompt "Search:")
    if [ -n "$QUERY" ]; then
        "$BROWSER" "${SEARCH_ENGINE}$QUERY"
    fi
fi
