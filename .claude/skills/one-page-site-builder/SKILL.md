---
name: one-page-site-builder
description: 指定された技術スタックや、作成指針に従ってHTMLを生成します。ユーザーの指示が結局は、HTMLの作成や編集を意図しているときに使います。ランディングページ、ページ、Webページ、ホームページ作成・編集を行う時に使います。
---

非エンジニア向けの、ワンページ完結型・高品質HTML生成スキル。

ランディングページ・サービス紹介・ポートフォリオ・イベント告知・プロフィールページなど、1ページに情報をまとめたいケース。「ワンページで」「LP」「1枚もの」などの指示が目安。

ダッシュボード・管理画面・動的SPAには使わない。

あなたの仕事は、

- **作成**: ユーザーがコンテンツを任せたい場合は創造性を発揮する。コンテンツが事前に決まっている場合はそれに従う
- **編集**: 指定箇所を編集する

作成・編集のあとは、必ず「生成後の確認」（末尾）まで実施する。

## 保存先

文脈・設定ファイルから判断。不明ならユーザーに確認。UTF-8で保存すること。

## 技術スタック

### ライブラリ

以下の CDN タグをそのまま使う。バージョンは 2026-08 時点でブラウザ実機で動作確認済み。

**読み込み位置**: `<link rel="stylesheet">` と Tailwind の `<script>` は `<head>` に置く。
それ以外の `<script src>` と初期化コード（`AOS.init()` / `lucide.createIcons()`）は
**`</body>` の直前**に置くこと。`<head>` で初期化を呼ぶと対象の DOM がまだ無く、アイコンもアニメーションも動かない。

**Tailwind CSS v4**（v3 の `<link>` 形式は不可）
```html
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
```

カスタムテーマは `<style type="text/tailwindcss">` 内の `@theme` で定義：
```html
<style type="text/tailwindcss">
  @theme {
    --color-primary: #3b82f6;
    --font-sans: 'Noto Sans JP', sans-serif;
  }
</style>
```

**Animate.css v4.1.1**（アニメーション。控えめに）— `<head>` に置く
```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
```

**AOS v2.3.4**（スクロールアニメーション。Animate.css + Intersection Observer で代替してもよい）
```html
<!-- <head> に -->
<link rel="stylesheet" href="https://unpkg.com/aos@2.3.4/dist/aos.css">
<!-- </body> の直前に -->
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>AOS.init();</script>
```

**Lucide v1.32.0**（一般アイコン / https://lucide.dev/icons ）
```html
<!-- </body> の直前に -->
<script src="https://unpkg.com/lucide@1.32.0/dist/umd/lucide.min.js"></script>
<script>lucide.createIcons();</script>
```
アイコンは `<i data-lucide="menu"></i>` のように書く。DOM を後から差し替えたら `lucide.createIcons()` を再実行する。

**v1 で名前が変わったアイコンがある。** 記憶で書かず、迷ったら https://lucide.dev/icons で確認すること。主な変更:

| v0 までの名前 | v1 での名前 |
|---|---|
| `align-center` / `align-left` など | `text-align-center` / `text-align-left` |
| `smile` / `frown` / `angry` | `face-smiling` / `face-slightly-frowning` / `face-angry` |
| `indent-increase` / `indent-decrease` | `list-indent-increase` / `list-indent-decrease` |
| `wrap-text` | `text-wrap` |
| `fingerprint` | `fingerprint-pattern` |
| `file-check-2` など `-2` 系 | `file-check-corner` など `-corner` 系 |

**ブランドロゴ（SNS等）は Lucide にはない。** 次項の Simple Icons を使うこと。

**Simple Icons v16**（ブランドロゴ / https://simpleicons.org/ ）

Lucide は商標・意匠上の理由でブランドロゴを持たず、公式に Simple Icons を案内している（https://lucide.dev/brand-logo-statement ）。CDN で読み込むライブラリではなく、**SVG を1つずつ HTML に直接埋め込んで使う**。

取得は次のスクリプトで行う（プロジェクトルートから実行）:
```bash
bash .claude/skills/one-page-site-builder/brand-icon.sh instagram facebook line
```

出力された `<svg>` をそのまま HTML に貼る。スクリプトは `fill="currentColor"` を付けて出力するので、**親要素の文字色をそのまま継承する**（Simple Icons の元データには `fill` が無く、素のまま貼ると黒一色で描画され、暗い背景のフッターでは見えなくなる）。

- サイズは `class="w-5 h-5"` を変更して調整する
- **`aria-hidden="true"` を付けた SVG は、必ず囲む `<a>` 側に `aria-label` を付けること**（付け忘れるとリンクの内容が読み上げられない）
- slug が分からない・404 になる場合は https://simpleicons.org/ で検索する。ブランド名の変更でslugが変わることがある（例: `twitter` → `x`）
- **ブランドロゴは各社の商標**。改変（色替え・変形・一部切り出し）はせず、各社のブランドガイドラインに従って使うこと

Lucide は線（stroke）、Simple Icons は塗り（fill）で描かれている。並べて置くと Simple Icons のほうが重く見えるので、必要ならサイズを一段小さくして視覚的な重さを揃える。

### HTML
- セマンティック要素・各セクションにID・メタタグ（description, keywords, og:image等）・ファビコン
- レスポンシブ（モバイルファースト）、画像に `loading="lazy" decoding="async"`

## デザイン

- カラーパレットは `@theme` で設定（コンテンツに合わせて選ぶ）
- フォントはパフォーマンスを考慮して選択

### コンテンツ構造

セクション構成の指示がある場合はそれに従う。指示がなければ自分で設計する。

判断基準は**セクション数ではなく、そのページの目的に対して必要な情報が揃っているか**。

よく使う構成要素（すべてを入れる必要はない）:
Hero / 課題提起・共感 / 提供価値 / 特徴・機能 / 使い方・流れ / 実績・お客様の声 / 料金 / 運営者・About / FAQ / CTA / フッター

- 目安は 6〜10 セクション。ただしこれは下限のノルマではない
- **素材が薄いときにセクションを水増ししない**。数を減らして 1 セクションの密度と説得力を上げる
- 逆に情報量が多いときは、無理に詰め込まず分割・整理する
- ヒーローセクションから始め、ナビゲーションを重ね、洗練されたイメージを与える
- ナビゲーションリンクを設置（セクションが多い場合は主要なものに絞る）
- フォームにはバリデーションを実装
- 適度に画像を使用（背景画像も可）

### 画像について

- ユーザー指定がなければ unsplash.com から選ぶ（`unsplash-image-finder` スキルを使う）
- URLを最適化する例: `https://images.unsplash.com/photo-xxx?w=1200&q=80&fm=webp&fit=crop`
- リンク切れは「生成後の確認」でネットワークログを見て確認する（目視や推測で済ませない）

## ナビゲーション仕様

### 意図

Hero の上では背景に溶け込んで邪魔をせず、スクロールして本文に入ったら背景から分離して確実に読める状態にする。

### 必須要件

- `position: fixed` で上部固定（`sticky` 不可）
- 初期状態と、スクロール後の状態で見た目を切り替える（初期は透明寄り、スクロール後は背景を敷いて可読に）
- スクロールイベントは必ずスロットリングする（`requestAnimationFrame` など。手法は問わない）
- レスポンシブ：`lg:` ブレークポイントでデスクトップ / モバイルメニューを切替

### アクセシビリティ（必須）
- `<nav>` に `aria-label`
- モバイルメニューボタンに `aria-expanded`・`aria-controls`・`aria-label`、開閉時に動的更新
- アイコンは Lucide の `menu` ⇔ `x` で切替

### デザイン

切替のしきい値・背景色や不透明度・ぼかしの強さ・トランジション速度・影は、全体デザインに合わせて判断する。
（例として、スクロール 50px 前後で切り替え、`backdrop-filter: blur(12px)` + 白の半透明背景 70% 程度、はよく機能する組み合わせ）

## 生成後の確認

HTML を書いて終わりにしない。**ユーザーに「ブラウザで確認してください」と丸投げしない。**

1. プレビューサーバを起動する（`.claude/launch.json` の `Static Site (serve)`。Claude Code のプレビュー機能がこの設定を読む）
   - プレビュー機能が使えない環境（ターミナル版の Claude Code など）では `npx serve public` を実行し、`http://localhost:3000` を開いてもらうようユーザーに伝える。そのうえで、ソースから確認できる範囲（CDN の URL・`data-lucide` 名・aria 属性・画像 URL の到達性）は自分で確認する
2. ページを開いて、以下を確認する
   - **コンソールエラーがないか**
   - **ネットワークログに 404 がないか**（特に Unsplash 画像・CDN のリンク切れ）
   - デスクトップ幅・モバイル幅の両方でレイアウトが崩れていないか
   - 固定ナビがスクロール前後で切り替わるか
   - モバイルメニューが開閉し、`aria-expanded` が更新されるか
   - Lucide アイコンが描画されているか（`<i data-lucide>` が `<svg>` に置き換わらず残っていたら名前が間違っている。コンソールにも警告が出る）
   - ブランドアイコン（Simple Icons）が意図した色で見えているか（黒のまま暗い背景に溶けていないか）
3. 問題があればソースを修正し、再確認する
4. 直せなかった点があれば、何がどう残っているかを明示してユーザーに伝える
