# Claude1page

Claude Code を使って、シンプルで、モダンで、美しい、ワンページで完結するWebページを作るためのスターターキットです。Cloudflare Pagesで簡単に公開できるように設計されています。

## 更新履歴

- 2025年 10月 27日:
  - `.rgignore` を使って、prompt.md などを検索対象除外から除外（これで、Claude Code で @ で指定できるようになった）
  - README.md を Cloudflareの説明などに変更（Unsplashの設定も推奨に設定、環境変数対応についても記載など）


## 必要なもの

- **Claude Code の事前インストール**
- **Visual Studio Code**
- **おすすめの拡張機能**
	- Claude Code
  - Live Server
  - Prettier - Code formatter

あるいは、Cloude Code on the Web でも利用可能です。

## 準備

1. **リポジトリからクローン**
   ```bash
   mkdir project-name
   cd project-name
   git clone https://github.com/toiee-lab/claude1page.git .
   ```

2. **リポジトリの初期化**
   ```bash
   rm -rf .git
   git init
   ```

3. **Unsplash API設定**

   高品質な画像を検索し、Webページに自動設定するために、Unsplash の **API キーの設定を強く推奨します** 。

   **APIキーの取得方法：**
   1. [Unsplash Developers](https://unsplash.com/developers) にアクセス
   2. "Register as a developer" でアカウント登録
   3. "New Application" で新しいアプリケーションを作成
   4. Access Key を取得

   APIキーは、以下のように、 `.env.local` ファイルに設定しても良いですし、環境変数に設定しても良いです。環境変数に設定した方が、他のプロジェクトでも設定不要になるので、環境変数への設定をお勧めします。

   まず、必要なライブラリをインストールします（忘れずに！）
   ```bash
   npm install
   ```

   環境変数に設定する場合は、以下のようなコマンド（here-is-your-keyを書き換えた上で）を実行します。

   macOSの場合
   ```zsh
   echo 'export UNSPLASH_ACCESS_KEY=here-is-your-key' >> ~/.zshrc && source ~/.zshrc
   ```

   Windowsの場合（PowerShellで実行）
   ```powershell
   if (!(Test-Path $PROFILE)) { New-Item -Path $PROFILE -ItemType File -Force }; Add-Content -Path $PROFILE -Value '$env:UNSPLASH_ACCESS_KEY="here-is-your-key"'; . $PROFILE
   ```

   あるいは、APIキー設定用のファイルを作成し、中身を編集してください。見ればわかります。
   cp .env.local.example .env.local

   テストは、以下の通りです。

   ```bash
   node dev-tools/unsplash-search.js "キーワード"
   ```


4. **作る**
   - Claude Code を起動して、Webページの作成を開始してください


## ポイント

- **プロンプトファイルの活用**
  - `prompt.md` や `prompt2.md` などのファイルを作って、プロンプトを書いてコピペすると便利です（gitに保存されません）
  - あるいは、 prompt.md にプロンプトを書き込み、保存し、 `@prompt.md` で呼び出しても良いです

- **コンテンツの管理**
  - `project-docs` ディレクトリに、コンテキストコンテンツなどを保管して、呼び出すと便利です

- **画像の自動取得**
  - Unsplash APIを設定すると、Claude Codeが自動で高品質な画像を検索・取得します
  - 手動で画像を探す手間が省けて、作業効率が大幅に向上します
  - 取得される画像は最適化済み（WebP形式、適切なサイズ）で、ページの読み込み速度も向上します

## プロンプト例

```
Webページを作成してください。

- ここにありったけ、情報を書いてください
- どんなデザインが良いのか？
- もし、カラーが決まっているなら指定する
- 誰向けのものなのか？
- あなたが伝えたいこと、あなたの強み、特徴など
- お店の名前や、プロダクトについての説明など
- 難しく考えず、たくさん書いて、あとはClaudeに任せましょう
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
