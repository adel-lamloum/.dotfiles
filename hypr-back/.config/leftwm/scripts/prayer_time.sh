#!/bin/bash

# API endpoint to get prayer times for Abu Simbel, Egypt
API_URL="http://api.aladhan.com/v1/timingsByCity?city=Abu%20Simbel&country=Egypt&method=2"

# Fetch prayer times
response=$(curl -s "$API_URL")

# Extract prayer times
fajr=$(echo "$response" | jq -r '.data.timings.Fajr')
dhuhr=$(echo "$response" | jq -r '.data.timings.Dhuhr')
asr=$(echo "$response" | jq -r '.data.timings.Asr')
maghrib=$(echo "$response" | jq -r '.data.timings.Maghrib')
isha=$(echo "$response" | jq -r '.data.timings.Isha')

# Get current time
current_time=$(date +"%H:%M")

# Determine the next prayer time
if [[ "$current_time" < "$fajr" ]]; then
    next_prayer="Fajr: $fajr"
elif [[ "$current_time" < "$dhuhr" ]]; then
    next_prayer="Dhuhr: $dhuhr"
elif [[ "$current_time" < "$asr" ]]; then
    next_prayer="Asr: $asr"
elif [[ "$current_time" < "$maghrib" ]]; then
    next_prayer="Maghrib: $maghrib"
elif [[ "$current_time" < "$isha" ]]; then
    next_prayer="Isha: $isha"
else
    # If current time is after Isha, show Fajr of the next day
    next_prayer="Fajr (Tomorrow): $fajr"
fi

# Output the next prayer time
echo "$next_prayer"
