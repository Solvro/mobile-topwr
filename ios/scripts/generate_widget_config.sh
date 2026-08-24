#!/bin/bash
# generate_widget_config.sh
# Reads the project .env file and generates Config.generated.swift
# for native iOS widget extensions. Run as an Xcode Build Phase.

set -e

ENV_FILE="${SRCROOT}/../.env"
OUTPUT_FILE="${SRCROOT}/WidgetConfig/Config.generated.swift"

if [ ! -f "$ENV_FILE" ]; then
    echo "error: .env file not found at $ENV_FILE"
    exit 1
fi

# Read values from .env
get_env_value() {
    local key="$1"
    local value
    value=$(grep "^${key}=" "$ENV_FILE" | head -1 | cut -d'=' -f2-)
    value="${value%\"}"
    value="${value#\"}"
    value="${value%\'}"
    value="${value#\'}"
    echo "$value"
}

MAIN_REST_API_URL=$(get_env_value "MAIN_REST_API_URL")
PARKING_API_URL=$(get_env_value "PARKING_API_URL")

mkdir -p "$(dirname "$OUTPUT_FILE")"

cat > "$OUTPUT_FILE" << EOF
// Auto-generated from .env — DO NOT EDIT
// Generated at: $(date -u +"%Y-%m-%dT%H:%M:%SZ")

import Foundation

enum WidgetConfig {
    static let mainRestApiUrl = "$MAIN_REST_API_URL"
    static let parkingApiUrl = "$PARKING_API_URL"
}
EOF

echo "Generated $OUTPUT_FILE"
