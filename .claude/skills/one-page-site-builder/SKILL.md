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

**Lucide v0.536.0**（アイコン / https://lucide.dev/ ）
```html
<!-- </body> の直前に -->
<script src="https://unpkg.com/lucide@0.536.0/dist/umd/lucide.min.js"></script>
<script>lucide.createIcons();</script>
```
アイコンは `<i data-lucide="menu"></i>` のように書く。DOM を後から差し替えたら `lucide.createIcons()` を再実行する。

**このバージョンを勝手に上げないこと。** v1 系ではブランドアイコン（`instagram` / `facebook` / `twitter` / `youtube` など）が本体から削除されており、フッターの SNS リンクが空欄になる（2026-08 に v1.32.0 で実機確認済み）。上げる場合は「生成後の確認」で、使うアイコンが全て描画されることを実地で確かめてから行う。

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
   - Lucide アイコンが描画されているか（`data-lucide` が空のままになっていないか）
3. 問題があればソースを修正し、再確認する
4. 直せなかった点があれば、何がどう残っているかを明示してユーザーに伝える
