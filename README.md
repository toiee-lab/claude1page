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
   git clone [このリポジトリのURL]
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

## ポイント

- **プロンプトファイルの活用**
  - `prompt.md` や `prompt2.md` などのファイルを作って、プロンプトを書いてコピペすると便利です（gitに保存されません）
  
- **コンテンツの管理**
  - `project-docs` ディレクトリに、コンテンツや画像などを保管して、呼び出すと便利です

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
├── CLAUDE.md          # Claude Code用の指示書
└── README.md          # このファイル
```

## Netlifyでの公開

1. Netlifyにログイン
2. 「New site from Git」を選択
3. このリポジトリを選択
4. Publish directory を `public` に設定
5. Deploy

これで、あなたの美しいワンページWebサイトが公開されます！