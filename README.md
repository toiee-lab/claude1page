# Webpage Template for Claude Code

Claude Code を使って、シンプルで、モダンで、美しい、ワンページで完結するWebページを作るためのスターターキットです。Netlifyで簡単に公開できるように設計されています。

## 必要なもの

- **Visual Studio Code**
- **おすすめの拡張機能**
  - Live Server
  - Prettier - Code formatter
  - Auto Rename Tag
- **Claude Code の事前インストール**

## 準備

1. **リポジトリからクローン**
   ```bash
   git clone https://github.com/toiee-lab/webpage-template-for-cc.git
   cd webpage-template-for-cc
   ```

2. **.git ディレクトリを削除**
   ```bash
   rm -rf .git
   git init
   ```

3. **CLAUDE.md を書き換える**
   - プロジェクトの内容に合わせて `CLAUDE.md` を編集してください
   - あなたのWebサイトの概要や要件を記載してください

4. **作る**
   - Claude Code を起動して、Webページの作成を開始してください

5. **Unsplash API設定（オプション）**
   
   より高品質な画像を自動で取得したい場合は、Unsplash APIを設定できます：
   
   ```bash
   # 1. 依存関係をインストール
   npm install
   
   # 2. APIキー設定用のファイルを作成
   cp .env.local.example .env.local
   ```
   
   **APIキーの取得方法：**
   1. [Unsplash Developers](https://unsplash.com/developers) にアクセス
   2. "Register as a developer" でアカウント登録
   3. "New Application" で新しいアプリケーションを作成
   4. Access Key を取得して `.env.local` に設定
   
   ```env
   UNSPLASH_ACCESS_KEY=your_actual_access_key_here
   ```
   
   テストは、以下の通りです。
   
   ```bash
   node dev-tools/unsplash-search.js "キーワード"
   ```

   設定後、Claude Codeは自動的に最適な画像を検索・取得します。

## ポイント

- **プロンプトファイルの活用**
  - `prompt.md` や `prompt2.md` などのファイルを作って、プロンプトを書いてコピペすると便利です（gitに保存されません）
  
- **コンテンツの管理**
  - `project-docs` ディレクトリに、コンテンツや画像などを保管して、呼び出すと便利です

- **画像の自動取得**
  - Unsplash APIを設定すると、Claude Codeが自動で高品質な画像を検索・取得します
  - 手動で画像を探す手間が省けて、作業効率が大幅に向上します
  - 取得される画像は最適化済み（WebP形式、適切なサイズ）で、ページの読み込み速度も向上します

## プロンプト例

```
シンプルで美しいコーポレートサイトを作成してください。
- 会社名: 〇〇株式会社
- 事業内容: Webマーケティング支援
- 色: ブルー系
- セクション: Hero、About、Services、Contact
```

## ファイル構成

```
webpage-template-for-cc/
├── public/              # Netlify公開用ディレクトリ
│   ├── index.html      # メインページ
│   └── assets/         # CSS、JS、画像などの静的ファイル
├── project-docs/       # プロジェクト関連ドキュメント
├── dev-tools/          # 画像検索ツール（オプション）
│   ├── package.json
│   ├── unsplash-search.js
│   └── README.md
├── CLAUDE.md          # Claude Code用の指示書
├── .env.local.example # API設定テンプレート
└── README.md          # このファイル
```

## Netlifyでの公開

1. Netlifyにログイン
2. 「New site from Git」を選択
3. このリポジトリを選択
4. Publish directory を `public` に設定
5. Deploy

これで、あなたの美しいワンページWebサイトが公開されます！