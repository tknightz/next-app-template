#!/bin/bash

LINT_CMD="bunx biome check ."
BUILD_CMD="bun run build"

echo "=== Running Verification ==="

echo ""
echo "=== Lint Check ==="
eval "$LINT_CMD"
LINT_EXIT=$?

if [ $LINT_EXIT -ne 0 ]; then
    echo ""
    echo "❌ Lint check failed."
    exit 1
fi

echo ""
echo "=== Build Check ==="
eval "$BUILD_CMD"
BUILD_EXIT=$?

if [ $BUILD_EXIT -ne 0 ]; then
    echo ""
    echo "❌ Build failed."
    exit 1
fi

echo ""
echo "✅ All verification checks passed."
