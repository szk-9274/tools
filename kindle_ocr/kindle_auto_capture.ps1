Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

# ===== Configuration =====
$X = -2480
$Y = -380
$Width  = 1200
$Height = 1850

$SaveDir = "C:\00_mycode\tools\kindle_ocr\output"
$Pages = 430          # Number of pages to capture
$DelayShot = 300      # Delay before/after screenshot (ms)
$DelayPage = 300      # Delay after page turn (ms)
# =========================

# Ensure output directory exists
if (!(Test-Path $SaveDir)) {
    New-Item -ItemType Directory -Path $SaveDir | Out-Null
}

Write-Host "Starting in 5 seconds. Please focus the Kindle window."
Start-Sleep -Seconds 5

for ($i = 1; $i -le $Pages; $i++) {

    $fileName = "page_{0:D4}.png" -f $i
    $OutputPath = Join-Path $SaveDir $fileName

    Write-Host "Capturing page $i..."

    # --- Screenshot ---
    $bitmap = New-Object System.Drawing.Bitmap $Width, $Height
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)

    $graphics.CopyFromScreen($X, $Y, 0, 0, $bitmap.Size)
    $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)

    $graphics.Dispose()
    $bitmap.Dispose()

    Write-Host "Saved: $fileName"

    Start-Sleep -Milliseconds $DelayShot

    # --- Page turn (RIGHT key) ---
    Write-Host "Sending RIGHT key..."
    [System.Windows.Forms.SendKeys]::SendWait("{RIGHT}")

    Start-Sleep -Milliseconds $DelayPage
}

Write-Host "Capture completed."
