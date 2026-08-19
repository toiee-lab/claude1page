#!/bin/bash
# Simple Icons からブランドアイコン（SNSロゴ等）を取得し、HTML に貼れる形で出力する
# 使い方: bash .claude/skills/one-page-site-builder/brand-icon.sh instagram facebook line
#
# Lucide は v1 でブランドロゴを本体から削除した（商標・意匠の都合）。
# 公式が代替として Simple Icons を案内している。
#   https://lucide.dev/brand-logo-statement
#
# 出力される SVG は fill="currentColor" なので、親要素の文字色をそのまま継承する。
# Simple Icons の元データには fill 属性が無く、そのまま貼ると黒で描画されるため
# このスクリプトを通すこと。

set -euo pipefail

# メジャーバージョン固定（上げるときは実際に描画を確認すること）
SI_VERSION="16"
BASE_URL="https://cdn.jsdelivr.net/npm/simple-icons@${SI_VERSION}/icons"
SLUGS_URL="https://github.com/simple-icons/simple-icons/blob/master/slugs.md"

if [ "$#" -eq 0 ]; then
  cat >&2 <<'USAGE'
使い方: brand-icon.sh <slug> [slug...]

例: bash .claude/skills/one-page-site-builder/brand-icon.sh instagram facebook line

slug は https://simpleicons.org/ で検索するか、slugs.md を参照してください。
よく使うもの: instagram / facebook / x / youtube / line / tiktok / threads / note / github
（旧 twitter は x に変わりました）
USAGE
  exit 1
fi

for slug in "$@"; do
  # 英小文字・数字・ハイフンのみ許可（パストラバーサル・SSRF 防止）
  if [[ ! "$slug" =~ ^[a-z0-9-]+$ ]]; then
    echo "error: slug に使えるのは英小文字・数字・ハイフンのみです: ${slug}" >&2
    exit 1
  fi

  if ! svg=$(curl -fsL "${BASE_URL}/${slug}.svg" 2>/dev/null); then
    echo "error: '${slug}' が見つかりませんでした（Simple Icons v${SI_VERSION}）" >&2
    echo "       正しい slug は ${SLUGS_URL} で確認してください。" >&2
    echo "       ブランド名が変わっている場合があります（例: twitter → x）。" >&2
    exit 1
  fi

  # <title> を除去し（リンク側の aria-label で読ませるため）、
  # role="img" を外して aria-hidden="true"・fill="currentColor" を付ける
  printf '<!-- %s -->\n' "$slug"
  printf '%s\n\n' "$svg" | sed \
    -e 's|<title>[^<]*</title>||g' \
    -e 's| role="img"||' \
    -e 's|<svg |<svg class="w-5 h-5" fill="currentColor" aria-hidden="true" |'
done

cat <<'NOTE'
--- 貼り付け方 ---
アイコン単体では意味が伝わらないため、必ずリンク側に aria-label を付けること:

<a href="https://instagram.com/xxx" aria-label="Instagram">
  （ここに上の SVG を貼る）
</a>

サイズは class の w-5 h-5 を変更して調整する。
色は親要素の文字色を継承する（例: 親に text-white を付ければ白くなる）。
NOTE
