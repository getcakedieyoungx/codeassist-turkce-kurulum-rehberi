# macOS Detaylı Kurulum Rehberi

Bu dokuman, macOS (Intel & Apple Silicon) üzerinde CodeAssist'i kurmanızı anlatır.

---

## Ön Koşullar

- macOS 10.14+ (Mojave ve üzeri)
- Intel Mac veya Apple Silicon (M1, M2, M3)
- Sudo erişimi veya admin hakkı
- 20GB boş disk alanı
- Aktif internet bağlantısı

---

## Adım 1: Xcode Command Line Tools

### 1.1 Yükle

```bash
xcode-select --install
```

**Terminal penceresinde tıkla ve yüklemesi bitmesini bekle.**

### 1.2 Kontrol Et

```bash
xcode-select --print-path
# Çıktı: /Applications/Xcode.app/Contents/Developer
```

---

## Adım 2: Homebrew Kurulumu

### 2.1 Homebrew Yükle

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2.2 Shell Yapılandırması

**Apple Silicon (M1/M2/M3):**
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

**Intel Mac:**
```bash
# Üstüne yazanı var ise atla
```

### 2.3 Kontrol Et

```bash
brew --version
```

---

## Adım 3: Python 3.11 Kurulumu

### 3.1 Homebrew ile Kur

```bash
brew install python@3.11
```

### 3.2 PATH'e Ekle

```bash
# ~/.zprofile veya ~/.zshrc dosyasına ekle
echo 'export PATH="/usr/local/opt/python@3.11/bin:$PATH"' >> ~/.zprofile
source ~/.zprofile
```

### 3.3 Kontrol Et

```bash
python3.11 --version
pip3.11 --version
```

---

## Adım 4: Git Kurulumu

```bash
brew install git

# Yapılandır
git config --global user.name "Adı Soyadı"
git config --global user.email "email@example.com"

# SSH key (isteğe bağlı)
ssh-keygen -t ed25519 -C "email@example.com"
```

---

## Adım 5: Docker Kurulumu

### 5.1 Docker Desktop Yükle

1. [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop) indir
2. DMG dosyasını aç
3. Docker.app'i Applications'a sürük
4. Applications'dan Docker'i çalıştır

### 5.2 Kontrol Et

```bash
docker --version
docker ps  # Daemon çalışıyor mu?
```

---

## Adım 6: UV Package Manager Kurulumu

### 6.1 Yükle

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### 6.2 Shell Konfigurasyonu

```bash
# Homebrew ile kuruluşsa:
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

# UV:
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zprofile
source ~/.zprofile
```

### 6.3 Kontrol Et

```bash
uv --version
```

---

## Adım 7: CodeAssist Klonlama

```bash
# Projeler dizini oluştur
mkdir -p ~/projects
cd ~/projects

# CodeAssist deposunu klonla
git clone https://github.com/gensyn-ai/codeassist.git
cd codeassist

# Dosyaları listele
ls -la
```

---

## Adım 8: CodeAssist'i Çalıştırma

```bash
cd ~/projects/codeassist

# İlk kez çalıştırma
uv run run.py
```

**Tarayıcıda açılmalı:** `http://localhost:3000`

---

## GPU Hızlandırması (İsteğe Bağlı)

### Apple Metal Performance Shaders (MPS)

**Apple Silicon Mac'lerde:** Metal otomatik olarak etkindir

**Kontrol et:**
```bash
python3.11 -c "import torch; print(torch.backends.mps.is_available())"
```

---

## Önemli Ayarlar

### Docker Bellek Sınırı

1. Docker >İpreferences > Resources
2. Memory: 8GB minimum (16GB önerilir)
3. CPU: 4+ çekirdek
4. Disk image size: 40GB

### Terminal Secimi

✅ **Önerilen:**
- iTerm2
- Warp
- kitty

❌ **Sakincalar:**
- Terminal.app (temel ama yeterli)

---

## Sorun Giderme

### "Command not found: python3.11"

```bash
# Homebrew path kontrol et
brew list python@3.11

# Shell'i yeniden başlat veya
export PATH="/usr/local/opt/python@3.11/bin:$PATH"
```

### Docker Daemon Çalışmıyor

```bash
# Docker Desktop'u aç
# Applications > Docker.app

# veya
open /Applications/Docker.app
```

### Port 3000 Şu anda Kullanımda

```bash
lsof -i :3000
kill -9 <PID>
```

### Intel vs Apple Silicon Farkı

**Apple Silicon için:**
```bash
# Universal binary kullan
arch -arm64 python3.11 -m pip install torch
```

---

## Performans İpuçları

### M-series Mac Optimizasyonu

```bash
# Metal ile hızlandir
export PYTORCH_ENABLE_MPS_FALLBACK=1

# Kod
import torch
device = torch.device("mps" if torch.backends.mps.is_available() else "cpu")
```

### Isı Yönetimi

- Docker Desktop'u kapat (kullanmadığın zaman)
- Fan kontrol: `brew install smcFanControl` (opsiyonel)
- Hava akışı iyi tutunan yerde koy

---

## Sistem Maintenance

```bash
# Python paketlerini güncelleştir
pip3.11 install --upgrade pip

# Homebrew güncellemesi
brew update
brew upgrade

# Disk temizliği
brew cleanup
```

---

*Son Güncelleme: 17 Kasım 2025*
