#!/bin/bash

# Tailwind CSS Build Script (Production)
# Tailwind CSS ビルドスクリプト（本番用・最適化あり）

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

echo "Building Tailwind CSS for production (minified)..."
echo "Tailwind CSS を本番用にビルド中（最適化あり）..."

npx @tailwindcss/cli \
  -i "${PROJECT_DIR}/src/input.css" \
  -o "${PROJECT_DIR}/public/assets/css/style.css" \
  --minify

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
  echo "✓ Production build completed successfully!"
  echo "✓ 本番用ビルドが完了しました！"

  # ファイルサイズを表示
  if [ -f "${PROJECT_DIR}/public/assets/css/style.css" ]; then
    SIZE=$(du -h "${PROJECT_DIR}/public/assets/css/style.css" | cut -f1)
    echo "  Output size / 出力サイズ: ${SIZE}"
  fi
else
  echo "✗ Production build failed (exit code: $EXIT_CODE)"
  echo "✗ 本番用ビルドに失敗しました（終了コード: $EXIT_CODE）"
fi

exit $EXIT_CODE
