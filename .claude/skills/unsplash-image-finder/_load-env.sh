#!/bin/bash
# .env.local から UNSPLASH_ACCESS_KEY を読み込む共通処理
# 使い方: 各スクリプトから source する（単体実行はしない）
# 注意: API キーはスクリプト内でのみ使用し、外部（Claude コンテキスト等）には渡さない
#
# 既に環境変数 UNSPLASH_ACCESS_KEY が設定されている場合は、それを優先し何もしない。

_c1p_env_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_c1p_project_root="$(cd "${_c1p_env_dir}/../../.." && pwd)"

if [ -z "${UNSPLASH_ACCESS_KEY:-}" ] && [ -f "${_c1p_project_root}/.env.local" ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    # Windows で作成された .env.local（CRLF 改行）に対応
    line="${line%$'\r'}"
    # コメント行・空行をスキップ
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    [[ -z "${line//[[:space:]]/}" ]] && continue
    # `=` を含まない行をスキップ
    [[ "$line" != *=* ]] && continue

    key="${line%%=*}"
    value="${line#*=}"
    # 前後の空白と `export ` 接頭辞を除去
    key="${key#"${key%%[![:space:]]*}"}"
    key="${key%"${key##*[![:space:]]}"}"
    key="${key#export }"
    key="${key#"${key%%[![:space:]]*}"}"
    value="${value#"${value%%[![:space:]]*}"}"
    value="${value%"${value##*[![:space:]]}"}"
    # 値を囲むクォートを剥がす
    if [[ "$value" == \"*\" && ${#value} -ge 2 ]]; then
      value="${value:1:${#value}-2}"
    elif [[ "$value" == \'*\' && ${#value} -ge 2 ]]; then
      value="${value:1:${#value}-2}"
    fi

    if [ "$key" = "UNSPLASH_ACCESS_KEY" ] && [ -n "$value" ]; then
      export UNSPLASH_ACCESS_KEY="$value"
      break
    fi
  done < "${_c1p_project_root}/.env.local"
fi

unset _c1p_env_dir _c1p_project_root
