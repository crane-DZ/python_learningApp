<#
    重置练习：把 notebooks\_template\ 里的空白母版覆盖回 notebooks\，动手区清空，重新练一遍。
    用法： powershell -NoProfile -ExecutionPolicy Bypass -File tools\reset_practice.ps1
    加 -NoBackup 则不备份（不建议，会直接丢掉你敲的代码）。
    新增课件：把空白版放进 notebooks\_template\，本脚本自动纳入重置范围。
#>
param([switch]$NoBackup)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$nbDir = Join-Path $root "notebooks"
$tplDir = Join-Path $nbDir "_template"

if (-not (Test-Path -LiteralPath $tplDir)) {
    Write-Host "找不到母版目录：$tplDir" -ForegroundColor Red
    exit 1
}
$templates = @(Get-ChildItem -LiteralPath $tplDir -Filter *.ipynb -File)
if ($templates.Count -eq 0) {
    Write-Host "母版目录里没有 .ipynb：$tplDir" -ForegroundColor Red
    exit 1
}

$bakDir = Join-Path $nbDir "_练习记录"
if ($NoBackup) {
    Write-Host "(-NoBackup) 跳过备份，当前内容会被直接覆盖。" -ForegroundColor Yellow
}
elseif (-not (Test-Path -LiteralPath $bakDir)) {
    New-Item -ItemType Directory -Path $bakDir | Out-Null
}

$stamp = Get-Date -Format "yyyyMMdd_HHmmss"
$done = 0
$backed = 0

foreach ($t in $templates) {
    $target = Join-Path $nbDir $t.Name
    if (-not $NoBackup -and (Test-Path -LiteralPath $target)) {
        $bakName = "{0}_{1}" -f $stamp, $t.Name
        Copy-Item -LiteralPath $target -Destination (Join-Path $bakDir $bakName) -Force
        Write-Host "已备份 → notebooks\_练习记录\$bakName" -ForegroundColor DarkGray
        $backed++
    }
    Copy-Item -LiteralPath $t.FullName -Destination $target -Force
    Write-Host "已还原 → notebooks\$($t.Name)" -ForegroundColor Green
    $done++
}

foreach ($f in @("data\mine.txt", "data\my_notes.txt", "data\guest.txt", "data\demo_write.txt", "data\demo.json")) {
    $p = Join-Path $root $f
    if (Test-Path -LiteralPath $p) { Remove-Item -LiteralPath $p -Force }
}

Write-Host ""
Write-Host ("重置完成：{0} 本课件已还原为空白版，{1} 份答案已备份。" -f $done, $backed) -ForegroundColor Green
Write-Host "接下来在 VS Code 里做两件事："
Write-Host "  1) 提示「文件已在磁盘上更改」→ 点 Revert（或关掉标签重新打开）"
Write-Host "  2) 点顶部 Restart 内核，让自检计数从 0 开始"
