# ===== 設定 =====
$ImagePattern = "C:\00_mycode\tools\kindle_ocr\output\page_*.png"
$OutputPdf    = "C:\00_mycode\tools\kindle_ocr\book.pdf"

# ===== 画像取得 & 数値順ソート =====
$images = Get-ChildItem $ImagePattern |
    Sort-Object {
        if ($_.BaseName -match '(\d+)$') {
            [int]$matches[1]
        } else {
            0
        }
    } |
    ForEach-Object { $_.FullName }

# ===== デバッグ表示（確認用） =====
$images | ForEach-Object { Write-Host $_ }

# ===== チェック =====
if ($images.Count -eq 0) {
    Write-Host "No images found."
    exit 1
}

# ===== img2pdf =====
img2pdf $images -o $OutputPdf

Write-Host "Done: $OutputPdf"
