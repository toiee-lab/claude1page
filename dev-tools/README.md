# Development Tools - Unsplash API統合

Claude Codeがローカル開発時に自動的に画像を取得するためのツールセットです。

## 📦 セットアップ

### 1. 依存関係のインストール

```bash
cd dev-tools
npm install
```

### 2. Unsplash API キーの設定

1. [Unsplash Developers](https://unsplash.com/developers) にアクセス
2. "Register as a developer" でアカウント登録
3. "New Application" で新しいアプリケーションを作成
4. Access Key を取得

### 3. 環境変数の設定

プロジェクトルートに `.env.local` ファイルを作成:

```bash
# プロジェクトルートで実行
cp .env.local.example .env.local
```

`.env.local` ファイルを編集して、実際のAPIキーを設定:

```env
UNSPLASH_ACCESS_KEY=your_actual_access_key_here
```

## 🚀 使用方法

### コマンドライン実行

```bash
# 単一キーワード検索
node unsplash-search.js "business team"

# 複数キーワード検索
node unsplash-search.js "technology,innovation,startup"

# ヘルプ表示
node unsplash-search.js
```

### Claude Code での自動実行

Claude Code が Webページを生成する際に、以下のコマンドを自動実行します:

```bash
# ビジネス関連の画像を取得
node dev-tools/unsplash-search.js "business professional"

# テクノロジー関連の画像を取得  
node dev-tools/unsplash-search.js "modern technology"
```

## 🎯 機能

### ✅ 主要機能
- キーワードベースの画像検索
- 最適化されたURL生成 (WebP形式、圧縮設定)
- 複数画像の一括検索
- エラー時のフォールバック画像
- Unsplash API利用規約準拠 (ダウンロード追跡)

### 🔧 技術仕様
- **画像最適化**: `w=800&q=80&fm=webp&fit=crop`
- **フォールバック**: Unsplash Source API使用
- **レート制限**: 複数検索時は200ms間隔
- **エラーハンドリング**: 包括的エラー処理とログ出力

## 📋 出力例

### 成功時
```
🔍 Searching for: "business team"
✅ Found image by John Doe
📸 Image URL: https://images.unsplash.com/photo-xyz?w=800&q=80&fm=webp&fit=crop

🎉 Result:
https://images.unsplash.com/photo-xyz?w=800&q=80&fm=webp&fit=crop
```

### 複数検索時
```
🔍 Searching for 3 images...
🔍 Searching for: "technology"
✅ Found image by Jane Smith
🔍 Searching for: "innovation" 
✅ Found image by Mike Johnson
🔍 Searching for: "startup"
✅ Found image by Sarah Wilson

🎉 Results:
technology: https://images.unsplash.com/photo-abc?w=800&q=80&fm=webp&fit=crop
innovation: https://images.unsplash.com/photo-def?w=800&q=80&fm=webp&fit=crop
startup: https://images.unsplash.com/photo-ghi?w=800&q=80&fm=webp&fit=crop
```

## 🛠️ Claude Code 連携

### HTML生成時の自動画像取得

Claude Code は以下のような場面で自動的にこのツールを実行します:

1. **Hero セクション**: `"hero banner business"`
2. **About セクション**: `"team professional portrait"`  
3. **Services セクション**: `"modern office workspace"`
4. **Contact セクション**: `"contact us communication"`

### 実行例
```bash
# Claude Codeが内部で実行
node dev-tools/unsplash-search.js "$(echo 'hero,about,services,contact')"
```

## ⚠️ 制限事項

### API制限
- **Demo mode**: 1時間に50リクエスト
- **Production mode**: 1時間に5000リクエスト
- 超過時は自動的にフォールバック画像を使用

### セキュリティ
- `.env.local` ファイルはgitignoreされています
- APIキーをリポジトリにコミットしないでください
- 他者とAPIキーを共有しないでください

## 🐛 トラブルシューティング

### よくあるエラー

#### APIキーが見つからない
```
❌ Error: UNSPLASH_ACCESS_KEY not found in .env.local
📝 Please create .env.local file with your Unsplash API key
📖 See .env.local.example for reference
```

**解決方法**: `.env.local` ファイルを作成し、正しいAPIキーを設定してください。

#### 依存関係が見つからない
```
Error: Cannot find module 'unsplash-js'
```

**解決方法**: `npm install` を実行してください。

#### 画像が見つからない
```
⚠️ No images found for "very_specific_keyword"
🔄 Using fallback image for "very_specific_keyword"
```

**解決方法**: より一般的なキーワードを使用するか、フォールバック画像を利用してください。

## 📚 リファレンス

- [Unsplash API Documentation](https://unsplash.com/documentation)
- [unsplash-js GitHub](https://github.com/unsplash/unsplash-js)
- [Unsplash API Guidelines](https://help.unsplash.com/en/articles/2511245-unsplash-api-guidelines)