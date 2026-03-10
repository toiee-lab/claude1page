# claude1page アップデートスクリプト (Windows PowerShell)
# Usage: irm https://raw.githubusercontent.com/toiee-lab/claude1page/main/scripts/update.ps1 | iex
$ErrorActionPreference = "Stop"

$BASE_URL = "https://raw.githubusercontent.com/toiee-lab/claude1page/main"

Write-Host ""
Write-Host "========================================" -ForegroundColor Blue
Write-Host "  claude1page アップデート" -ForegroundColor Blue
Write-Host "========================================" -ForegroundColor Blue
Write-Host ""

# カレントディレクトリに CLAUDE.md があるか確認
if (-not (Test-Path "CLAUDE.md")) {
    Write-Host "エラー: CLAUDE.md が見つかりません。" -ForegroundColor Red
    Write-Host "claude1page プロジェクトのルートディレクトリで実行してください。"
    exit 1
}

# --- 古いファイルの削除 ---
Write-Host "古いファイルを削除中..." -ForegroundColor Yellow

$oldFiles = @("package.json", "package-lock.json", "scripts\install_pkgs.sh", ".claude\agents\unsplash-image-finder.md")
foreach ($f in $oldFiles) {
    if (Test-Path $f) { Remove-Item $f -Force }
}
if (Test-Path "dev-tools") { Remove-Item "dev-tools" -Recurse -Force }

Write-Host "  done"

# --- ディレクトリ作成 ---
Write-Host "ディレクトリを準備中..." -ForegroundColor Yellow

$dirs = @(".claude\skills\unsplash-image-finder", "scripts")
foreach ($d in $dirs) {
    if (-not (Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}

Write-Host "  done"

# --- 最新ファイルのダウンロード ---
Write-Host "最新ファイルをダウンロード中..." -ForegroundColor Yellow

function Download-File {
    param([string]$RelPath)
    $url = "$BASE_URL/$($RelPath -replace '\\','/')"
    $dest = $RelPath
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
        Write-Host "  ✓ $RelPath" -ForegroundColor Green
    }
    catch {
        Write-Host "  ✗ $RelPath (ダウンロード失敗)" -ForegroundColor Red
    }
}

$files = @(
    "CLAUDE.md",
    ".claude\settings.json",
    ".claude\launch.json",
    ".rgignore",
    ".env.local.example",
    ".gitignore",
    ".claude\skills\unsplash-image-finder\SKILL.md",
    ".claude\skills\unsplash-image-finder\unsplash-search.js",
    "scripts\update.sh",
    "scripts\update.ps1",
    "README.md"
)

foreach ($file in $files) {
    Download-File -RelPath $file
}

# --- 完了 ---
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ アップデート完了！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "⚠️  注意:" -ForegroundColor Yellow
Write-Host "  CLAUDE.md をカスタマイズしていた場合は、"
Write-Host "  git diff で変更を確認し、必要に応じて再反映してください。"
Write-Host ""
