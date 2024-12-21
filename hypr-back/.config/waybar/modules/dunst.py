#!/usr/bin/env python3

import subprocess
import json

def get_notification_count():
    """
    Fetch the number of active notifications using dunstctl.
    """
    try:
        # Run dunstctl to get the number of active notifications
        result = subprocess.run(
            ["dunstctl", "count", "displayed"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        if result.returncode == 0:
            # Parse the output to get the count
            count = int(result.stdout.strip())
            return count
        else:
            print(f"Error: {result.stderr}")
            return 0
    except Exception as e:
        print(f"Exception: {e}")
        return 0

def main():
    """
    Main function to generate JSON output for Waybar.
    """
    # Get the number of active notifications
    notification_count = get_notification_count()

    # Define the JSON structure for Waybar
    waybar_output = {
        "text": f"{notification_count}",
        "tooltip": f"{notification_count} active notifications",
        "class": ["notification"] if notification_count > 0 else ["none"],
        "alt": "notification" if notification_count > 0 else "none"
    }

    # Print the JSON output
    print(json.dumps(waybar_output))

if __name__ == "__main__":
    main()
