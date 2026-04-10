#!/bin/bash

INSTALL_CMD="bun install"
START_CMD="bun run dev"

echo "=== Initializing Project ==="
echo "Current directory: $(pwd)"

echo ""
echo "=== Installing Dependencies ==="
eval "$INSTALL_CMD"

echo ""
echo "✅ Environment ready."
echo "Run './verify.sh' to run lint and build checks."
echo "Start command: $START_CMD"

if [ "$RUN_START_COMMAND" = "1" ]; then
    echo ""
    echo "=== Starting Dev Server ==="
    eval "$START_CMD"
fi
