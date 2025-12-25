#!/bin/bash

# Test deeplink on Android device via ADB
# Usage: ./test_deeplink.sh "https://topwr.solvro.pl/navigation"

if [ -z "$1" ]; then
    echo "Usage: $0 <deeplink_url>"
    echo ""
    echo "IMPORTANT: Always quote the URL, especially if it contains special characters like &, ?, ="
    echo ""
    echo "Examples:"
    echo "  $0 \"https://topwr.solvro.pl/navigation\""
    echo "  $0 \"https://topwr.solvro.pl/sci-clubs?q=robotics&tags=1,2,3\""
    echo "  $0 \"https://topwr.solvro.pl/guide/1?section=0\""
    exit 1
fi

DEEPLINK_URL="$1"
PACKAGE_NAME="com.solvro.topwr"

# Check if adb is available
if ! command -v adb &> /dev/null; then
    echo "Error: adb command not found. Please ensure Android SDK platform-tools are in your PATH."
    exit 1
fi

echo "Testing deeplink: $DEEPLINK_URL"
adb shell am start -W -a android.intent.action.VIEW -d "$DEEPLINK_URL" "$PACKAGE_NAME"

