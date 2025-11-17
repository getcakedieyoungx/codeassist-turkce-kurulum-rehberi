# CodeAssist Windows PowerShell Kurulum Scripti
# Bu script, Windows WSL2'de CodeAssist'i otomatik olarak kurar

# Renk tanımlamaları
function Write-Success { Write-Host "$args" -ForegroundColor Green }
function Write-Error { Write-Host "$args" -ForegroundColor Red }
function Write-Warning { Write-Host "$args" -ForegroundColor Yellow }
function Write-Info { Write-Host "$args" -ForegroundColor Cyan }

Write-Info "================================================"
Write-Info "CodeAssist Windows WSL2 Kurulum Scripti"
Write-Info "================================================"
Write-Info ""

# WSL Kontrol
Write-Warning "[1/5] WSL durumu kontrol ediliyor..."
$wslStatus = wsl --list --verbose 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ WSL2 kurulu değil. Lütfen 'wsl --install' komutunu çalıştır."
    exit 1
}

if (-not ($wslStatus -like "*Ubuntu*2*")) {
    Write-Error "❌ Ubuntu 22.04+ WSL2'de kurulu değil."
    Write-Info "Şu komutu çalıştır: wsl --install -d Ubuntu-22.04"
    exit 1
}

Write-Success "✓ WSL2 kurulu"

# WSL Ubuntu İçinde Kurulum
Write-Warning "[2/5] WSL Ubuntu içinde paketler yükleniyor..."
wsl bash -c "sudo apt update && sudo apt upgrade -y"
wsl bash -c "sudo apt install -y python3.11 python3.11-venv curl docker.io"

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Ubuntu paket yüklemesi başarısız."
    exit 1
}

Write-Success "✓ Ubuntu paketleri yüklendi"

# UV Package Manager
Write-Warning "[3/5] UV Package Manager yükleniyor..."
wsl bash -c "curl -LsSf https://astral.sh/uv/install.sh | sh"

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ UV yükleme başarısız."
    exit 1
}

Write-Success "✓ UV yüklendi"

# Git Yapılandırması
Write-Warning "[4/5] Git yapılandırılıyor..."
wsl bash -c "git config --global user.name 'CodeAssist User'"
wsl bash -c "git config --global user.email 'user@example.com'"

Write-Success "✓ Git yapılandırıldı"

# CodeAssist Deposu
Write-Warning "[5/5] CodeAssist deposu klonlanıyor..."
wsl bash -c "mkdir -p ~/projects && cd ~/projects && git clone https://github.com/gensyn-ai/codeassist.git"

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ CodeAssist klonlaması başarısız."
    Write-Info "Manuel klonla: wsl bash -c 'cd ~/projects && git clone https://github.com/gensyn-ai/codeassist.git'"
    exit 1
}

Write-Success "✓ CodeAssist klonlandı"

Write-Info ""
Write-Success "========================================"
Write-Success "✓ Kurulum başarıyla tamamlandı!"
Write-Success "========================================"
Write-Info ""
Write-Info "Sonraki adımlar:"
Write-Info "1. Docker Desktop'ı aç (WSL2 entegrasyonlu)"
Write-Info "2. WSL'i aç: wsl"
Write-Info "3. CodeAssist dizinine git: cd ~/projects/codeassist"
Write-Info "4. Başlat: uv run run.py"
Write-Info "5. Tarayıcıda aç: http://localhost:3000"
Write-Info ""
Write-Success "Mutlu kodlamalar! 🚀"
