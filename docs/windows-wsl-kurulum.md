# Windows WSL2 Detaylı Kurulum Rehberi

Bu dokuman, Windows 10/11 üzerinde WSL2 ve CodeAssist'i adım adım kurmanızı anlatır.

---

## Ön Koşullar

- Windows 10 (Build 19041+) veya Windows 11
- Yönetici erişimi
- 20GB boş disk alanı
- Aktif internet bağlantısı

---

## Adım 1: WSL2 Etkinleştirme

### 1.1 PowerShell'i Yönetici Olarak Açın

1. Başlat menüsünü açın
2. "PowerShell" yazın
3. "Windows PowerShell" (yönetici) seçeneğine sağ tıklayın
4. "Yönetici olarak çalıştır" seçin

### 1.2 WSL Özelliklerini Etkinleştirin

```powershell
# Gerekli Windows özelliklerini aktif edin
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

**Bilgisayarı yeniden başlatın.**

### 1.3 WSL 2 Olarak Varsayılan Yapın

```powershell
wsl --set-default-version 2
```

---

## Adım 2: Ubuntu 22.04 Kurulumu

### 2.1 Ubuntu Dağıtımını Yükleyin

```powershell
wsl --install -d Ubuntu-22.04
wsl -s Ubuntu-22.04
```

### 2.2 Ubuntu Terminali Açılırsa

**Not:** Kurulum sırasında bir terminal açılabilir. Açılırsa:

1. "UNIX username" (kullanıcı adı) girin (örn: `coder`)
2. "New UNIX password" (parola) girin
3. Parolayı onaylayın

### 2.3 WSL Durumunu Kontrol Edin

```powershell
wsl -l -v
```

Çıktı şuna benzer görünmeli:

```
  NAME                   STATE           VERSION
* Ubuntu-22.04           Running         2
```

Eğer VERSION "2" değilse:

```powershell
wsl --set-version Ubuntu-22.04 2
```

---

## Adım 3: WSL Terminali Açma

Ubuntu terminal'i açmak için:

**Seçenek 1 - Start Menüsü:**
1. Başlat menüsünü açın
2. "Ubuntu" yazın
3. "Ubuntu 22.04 LTS" seçin

**Seçenek 2 - PowerShell:**
```powershell
wsl
```

**Seçenek 3 - Windows Terminal:**
1. Windows Terminal'i açın
2. Yeni sekme açın (Alt + Shift + T)
3. Ubuntu profilini seçin

---

## Adım 4: WSL İçinde Sistem Güncellemesi

Ubuntu terminal'inde çalıştırın:

```bash
# Paket listelerini güncelle
sudo apt update

# Tüm paketleri yükselt
sudo apt upgrade -y
```

---

## Adım 5: Docker Kurulumu

### 5.1 Docker Desktop İndir

1. [Docker Desktop](https://www.docker.com/products/docker-desktop) sayfasına git
2. "Docker Desktop for Windows" indir
3. Installer'ı çalıştır
4. "Use WSL 2 instead of Hyper-V" seçeneğini işaretle
5. Kurulumu tamamla ve bilgisayarı yeniden başlat

### 5.2 WSL İçinde Docker Komut Satırı Araçları

```bash
sudo apt install -y docker.io
```

### 5.3 Docker Daemon'u Başlat

```bash
sudo service docker start

# Daemon'un çalışıp çalışmadığını kontrol et
sudo service docker status
```

**Otomatik Başlatma (İsteğe Bağlı):**

`/etc/wsl.conf` dosyasını oluştur:

```bash
sudo nano /etc/wsl.conf
```

Aşağıdaki içeriği ekle:

```ini
[boot]
command="service docker start"
```

`Ctrl + X`, ardından `Y`, sonra `Enter` ile kaydet.

---

## Adım 6: Python ve Gerekli Paketler

```bash
# Python 3.11 yükle
sudo apt install -y python3.11 python3.11-venv python3.11-dev

# Python'u varsayılan yap
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Pip yükle
sudo apt install -y python3-pip
```

---

## Adım 7: UV Package Manager Kurulumu

```bash
# UV'yi indir ve kur
curl -LsSf https://astral.sh/uv/install.sh | sh

# Shell'i yeniden başlat (veya manuel olarak)
source $HOME/.cargo/bin/env

# Versiyonu kontrol et
uv --version
```

---

## Adım 8: Git Kurulumu

```bash
sudo apt install -y git

# Git yapılandır
git config --global user.name "Adı Soyadı"
git config --global user.email "email@example.com"
```

---

## Adım 9: CodeAssist Klonlama

```bash
# Uygun bir dizin oluştur
mkdir -p ~/projects
cd ~/projects

# CodeAssist deposunu klonla
git clone https://github.com/gensyn-ai/codeassist.git
cd codeassist
```

---

## Adım 10: CodeAssist'i Çalıştırma

```bash
# CodeAssist dizininden
cd ~/projects/codeassist

# İlk kez çalıştırma (otomatik olarak Docker image'ini indirecek)
uv run run.py
```

**İlk kez:** 5-10 dakika alabilir (Docker image indiriliyor).

**Sonraki Çalıştırmalar:** Çok daha hızlı olur.

---

## Dosya Sistemi Entegrasyonu

### Windows'tan WSL Dosyalarına Erişim

**Dosya Gezgini'nde:**

```
\\wsl$\Ubuntu-22.04\home\<username>
```

Örnek:
```
\\wsl$\Ubuntu-22.04\home\coder\projects
```

### WSL'den Windows Dosyalarına Erişim

```bash
# Windows C: sürücüsü
cd /mnt/c

# Masaüstü klasörü
cd /mnt/c/Users/<username>/Desktop
```

---

## GPU Hızlandırması (İsteğe Bağlı)

### NVIDIA GPU Desteği

**Gereksinimler:**
- NVIDIA GPU (RTX 3090, 4090, A100, vb.)
- NVIDIA Driver 525.105.06+
- CUDA 12.4+ (WSL2 üzerinde)

### GPU Driver Kurulumu

```bash
# NVIDIA Driver'ı indir (Windows tarafında)
# https://www.nvidia.com/Download/driverDetails.aspx

# WSL'de CUDA Toolkit'i yükle
wsl
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"
sudo apt update
sudo apt install -y cuda-toolkit-12-4
```

### GPU Kontrolü

```bash
nvidia-smi
```

Çıktı GPU bilgilerini gösterecektir.

---

## Sorun Giderme

### "WSL 2 requires an update to its kernel component."

```powershell
# PowerShell'de (yönetici)
wsl --update
wsl --shutdown
```

### "The operation completed successfully, but no files were copied."

```powershell
# Ubuntu yeniden kur
wsl --unregister Ubuntu-22.04
wsl --install -d Ubuntu-22.04
```

### Docker Bağlantı Hatası

```bash
sudo usermod -aG docker $USER
newgrp docker

# Veya
sudo chmod 666 /var/run/docker.sock
```

### İşlemci Sınırlaması

`.wslconfig` dosyasını oluştur (Windows tarafında):

```
C:\Users\<username>\.wslconfig
```

İçerik:

```ini
[wsl2]
memory=8GB
processors=4
swap=2GB
```

---

## Günlük İşlemler

### CodeAssist'i Başlat

```bash
cd ~/projects/codeassist
uv run run.py
```

### Model Dosyalarına Erişim

```bash
cd ~/.codeassist/models
ls -la
```

### Log Dosyaları

```bash
cd ~/.codeassist/logs
ls -la
tail -f latest.log
```

---

*Son Güncelleme: 17 Kasım 2025*
