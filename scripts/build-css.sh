#!/bin/bash

# Tailwind CSS Build Script (Development)
# Tailwind CSS ビルドスクリプト（開発用）

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Check if src/input.css exists
if [ ! -f "${PROJECT_DIR}/src/input.css" ]; then
  # Silently skip if source file doesn't exist yet
  exit 0
fi

echo "Building Tailwind CSS..."
echo "Tailwind CSS をビルド中..."

npx @tailwindcss/cli \
  -i "${PROJECT_DIR}/src/input.css" \
  -o "${PROJECT_DIR}/public/assets/css/style.css"

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
  echo "✓ Tailwind CSS build completed successfully!"
  echo "✓ Tailwind CSS のビルドが完了しました！"
else
  echo "✗ Tailwind CSS build failed (exit code: $EXIT_CODE)"
  echo "✗ Tailwind CSS のビルドに失敗しました（終了コード: $EXIT_CODE）"
fi

exit $EXIT_CODE
