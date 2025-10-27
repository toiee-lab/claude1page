# Claude1page

Claude Code を使って、シンプルで、モダンで、美しい、ワンページで完結するWebページを作るためのスターターキットです。Cloudflare Pagesで簡単に公開できるように設計されています。

## 更新履歴

- 2025年 10月 27日:
  - `.rgignore` を使って、prompt.md などを検索対象除外から除外（これで、Claude Code で @ で指定できるようになった）
  - README.md を Cloudflareの説明などに変更（Unsplashの設定も推奨に設定、環境変数対応についても記載など）


## 必要なもの

- **Visual Studio Code**
- **おすすめの拡張機能**
  - Live Server
  - Prettier - Code formatter
  - Auto Rename Tag
- **Claude Code の事前インストール**

あるいは、Cloude Code on the Web でも利用可能（工夫が必要になりますが）

## 準備

1. **リポジトリからクローン**
   ```bash
   mkdir project-name
   cd project-name
   git clone https://github.com/toiee-lab/claude1page.git .
   ```

2. **.git ディレクトリを削除**
   ```bash
   rm -rf .git
   git init
   ```

3. **Unsplash API設定**
   
   高品質な画像を検索し、Webページに自動設定するために、Unsplash の API キーの設定を強く推奨します。
   APIキーは、以下のように、 `.env.local` ファイルに設定しても良いですし、環境変数に設定しても良いです。
   
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


4. **作る**
   - Claude Code を起動して、Webページの作成を開始してください


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

## Cloudflare Pagesでの公開

1. Cloudflareにログイン
2. コンピューティングとAI > Workers & Pages を選択
3. アプリケーションを作成 > Pagesタブ をクリック
4. 既存のGitリポジトリをインポートするを選び、リポジトリを選ぶ
5. 公開フォルダに、 `public` を設定する
6. Deploy
7. その後、必要に応じて、カスタムドメインなどを設定する

※ Cloudflare でドメインを管理すれば、すごく簡単にできるようになります


