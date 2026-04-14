#!/bin/bash

LINT_CMD="bunx biome check ."
BUILD_CMD="bun run build"
TEST_CMD="bun run test"
TEST_E2E_CMD="bun run test:e2e"

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
echo "=== Test Check ==="
eval "$TEST_CMD"
TEST_EXIT=$?

if [ $TEST_EXIT -ne 0 ]; then
    echo ""
    echo "❌ Tests failed."
    exit 1
fi

echo ""
echo "=== E2E Test Check ==="
eval "$TEST_E2E_CMD"
TEST_E2E_EXIT=$?

if [ $TEST_E2E_EXIT -ne 0 ]; then
    echo ""
    echo "❌ E2E tests failed."
    exit 1
fi

echo ""
echo "✅ All verification checks passed."
