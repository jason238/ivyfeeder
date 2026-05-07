param(
  [switch]$SkipInstall,
  [int]$Port = 4000,
  [string]$BindHost = "127.0.0.1"
)

$ErrorActionPreference = "Stop"

function Require-Command([string]$Name, [string]$InstallHint) {
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    Write-Host ""
    Write-Host "Missing required command: $Name" -ForegroundColor Red
    Write-Host $InstallHint
    Write-Host ""
    exit 1
  }
}

Push-Location $PSScriptRoot
try {
  Require-Command "ruby"   "Install Ruby (with DevKit): https://rubyinstaller.org/  (pick 'Ruby+Devkit' and allow MSYS2 setup)."
  Require-Command "bundle" "Bundler is usually included. If not: run `gem install bundler` in a terminal."

  if (-not $SkipInstall) {
    Write-Host "Installing gems (bundle install)..." -ForegroundColor Cyan
    bundle install
  }

  Write-Host ""
  Write-Host "Starting Jekyll dev server..." -ForegroundColor Green
  Write-Host "URL: http://$BindHost`:$Port" -ForegroundColor Green
  Write-Host ""

  bundle exec jekyll serve --livereload --host $BindHost --port $Port
}
finally {
  Pop-Location
}

