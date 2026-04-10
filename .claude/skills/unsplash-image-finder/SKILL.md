---
name: unsplash-image-finder
description: Search and optimize images from Unsplash for web pages. Use this skill when you need to find images for website content, hero sections, backgrounds, or any web design elements. Automatically triggered when creating web pages without user-provided images, or when user mentions needing images, photos, Unsplash, or visual content for websites. Optimizes images with width, quality, and format parameters for web performance.
user-invocable: true
---

# Unsplash Image Finder Skill

このスキルは、Webページ作成時にUnsplashから適切な画像を検索し、最適化されたURLを提供します。

## セキュリティ方針

**APIキーは絶対にClaudeのコンテキストに渡さない。**
シェルスクリプトが `.env.local` からAPIキーを直接読み込むため、Claudeはキーを参照しない。

## セットアップ確認（ヘルスチェック）

```bash
bash .claude/skills/unsplash-image-finder/unsplash-health-check.sh
```

- `status: "ok"` → 正常。ユーザーに「画像検索は使えます」と伝えてください。
- `status: "error"` → `message` と `guide` をユーザーに分かりやすく伝えてください。

## 使用方法

### ステップ1: 画像を検索する

```bash
bash .claude/skills/unsplash-image-finder/unsplash-search.sh "keyword"
```

スクリプトは Unsplash API の **生 JSON** を stdout に出力します。

**複数セクションに画像が必要な場合も1回の検索で済む：**
`per_page` のデフォルトは 10。`results[0]`〜`results[9]` から用途に応じて使い分けること（再検索不要）。

```bash
# 明示的に件数を指定する場合
bash .claude/skills/unsplash-image-finder/unsplash-search.sh "keyword" 5
```

### ステップ2: JSON から情報を取り出す

出力 JSON の構造：

```
results[n].urls.raw               → 画像のベースURL（パラメータ付加前）
results[n].user.name              → 撮影者名（クレジット表記用）
results[n].links.download_location → ダウンロード追跡URL（Unsplash規約必須）
```

### ステップ3: 画像URLを最適化する

`results[n].urls.raw` に以下のパラメータを付加する：

| パラメータ | 用途 | 推奨値 |
|---|---|---|
| `w` | 幅 | Hero: 1920 / コンテンツ: 800〜1200 / サムネイル: 400 |
| `q` | 品質 | 80（重要な画像は90） |
| `fm` | フォーマット | webp |
| `fit` | フィット | crop |

**例:**
```
https://images.unsplash.com/photo-xxx?w=1200&q=80&fm=webp&fit=crop
```

### ステップ4: ダウンロード追跡（Unsplash API 規約必須）

画像URLを使用したら、`results[n].links.download_location` の値を使って追跡リクエストを送る：

```bash
bash .claude/skills/unsplash-image-finder/unsplash-track.sh "download_location の URL"
```

`tracked` と出力されれば成功。失敗してもHTMLへの挿入は続行してよい。

## HTMLへの挿入

```html
<img
  src="https://images.unsplash.com/photo-xxx?w=800&q=80&fm=webp&fit=crop"
  alt="適切な説明文"
  loading="lazy"
  decoding="async"
  class="w-full h-64 object-cover"
/>
```

## フォールバック処理

1. **APIエラー / 検索結果なし**: 別キーワードで再検索（例: "coffee shop" → "cafe" → "coffee"）
2. **再検索でも取得できない場合**: `https://cwm.toiee.jp/images/dummy.jpg` を使用

## Unsplash利用規約

- 商用利用可（Unsplash License）
- 推奨クレジット表記:

```html
Photo by <a href="https://unsplash.com/@username?utm_source=claude1page&utm_medium=referral">撮影者名</a>
on <a href="https://unsplash.com?utm_source=claude1page&utm_medium=referral">Unsplash</a>
```

## 環境変数の設定方法

プロジェクトルートの `.env.local` に記載：

```
UNSPLASH_ACCESS_KEY=your_access_key_here
```

Access Key の取得: https://unsplash.com/developers → 「New Application」
