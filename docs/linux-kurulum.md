# Linux (Ubuntu 22.04+) Detaylı Kurulum Rehberi

Bu dokuman, Linux tabanılı sistemlerde CodeAssist'i kurmanızı anlatır.

---

## Ön Koşullar

- Ubuntu 22.04, 24.04 veya Debian 12+
- Sudo erişimi veya root kullanıcı
- 20GB boş disk alanı
- Aktif internet bağlantısı

---

## Adım 1: Sistem Güncellemesi

```bash
# Paket listelerini güncelle
sudo apt update

# Tüm paketleri yükselt
sudo apt upgrade -y

# Temizlik
sudo apt autoremove -y
```

---

## Adım 2: Temel Araçlar

```bash
sudo apt install -y \
  build-essential \
  curl \
  wget \
  git \
  vim \
  nano
```

---

## Adım 3: Python 3.11 Kurulumu

### 3.1 Python Repository Ekle

```bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
```

### 3.2 Python 3.11 Yükle

```bash
sudo apt install -y python3.11 python3.11-dev python3.11-venv
```

### 3.3 Varsayılan Yap (İsteğe Bağlı)

```bash
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1
```

### 3.4 Pip Yükle

```bash
sudo apt install -y python3-pip
```

---

## Adım 4: Docker Kurulumu

### 4.1 Docker Repository Ekle

```bash
# Docker imzalamak için anahtar ekle
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Repository ekle
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### 4.2 Docker'ı Kur

```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 4.3 Docker'ı Başlat

```bash
# Daemon'u başlat
sudo systemctl start docker

# Sistem açılışında otomatik başlasın
sudo systemctl enable docker

# Durumunu kontrol et
sudo systemctl status docker
```

### 4.4 Sudo Olmadan Docker Kullanma

```bash
# Docker grubunu oluştur (varsa atla)
sudo groupadd docker

# Mevcut kullanıcıyı gruba ekle
sudo usermod -aG docker $USER

# Grup değişikliğini uygula
newgrp docker

# Test et
docker ps
```

---

## Adım 5: UV Package Manager Kurulumu

```bash
# UV'yi indir ve kur
curl -LsSf https://astral.sh/uv/install.sh | sh

# Shell'i yeniden yükle
source $HOME/.cargo/bin/env

# Versiyonu kontrol et
uv --version
```

---

## Adım 6: Git Yapılandırması

```bash
# Global yapılandır
git config --global user.name "Adı Soyadı"
git config --global user.email "email@example.com"

# SSH Anahtarı Oluştur (İsteğe Bağlı)
ssh-keygen -t ed25519 -C "email@example.com"
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
# CodeAssist dizinine git
cd ~/projects/codeassist

# İlk kez çalıştırma
uv run run.py
```

**Tarayıcıda açılmalı:** `http://localhost:3000`

---

## Adım 9: Sistem Hizmeti Olarak Kurulum (İsteğe Bağlı)

CodeAssist'i arka planda çalıştırmak istiyorsanız:

### 9.1 Systemd Servisi Oluştur

```bash
sudo nano /etc/systemd/system/codeassist.service
```

Aşağıdaki içeriği ekle:

```ini
[Unit]
Description=CodeAssist Service
After=network.target docker.service
Requires=docker.service

[Service]
Type=simple
User=$USER
WorkingDirectory=/home/$USER/projects/codeassist
ExecStart=/root/.cargo/bin/uv run run.py
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

**$USER değerini kendi kullanıcı adıyla değiştir.**

### 9.2 Servisi Etkinleştir

```bash
# Systemd reload et
sudo systemctl daemon-reload

# Servisi etkinleştir
sudo systemctl enable codeassist

# Servisi başlat
sudo systemctl start codeassist

# Durumunu kontrol et
sudo systemctl status codeassist
```

### 9.3 Log Kontrol

```bash
# Gerçek zamanlı log
sudo journalctl -u codeassist -f

# Son 100 satırı göster
sudo journalctl -u codeassist -n 100
```

---

## GPU Hızlandırması (İsteğe Bağlı)

### NVIDIA GPU Desteği

**Gereksinimler:**
- NVIDIA GPU (RTX 3090, 4090, A100, H100, vb.)
- NVIDIA Driver 525.105.06+
- CUDA 12.4+

### GPU Driver Kurulumu

```bash
# NVIDIA Driver depolarını ekle
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update

# En yeni driver'ı kur
sudo apt install -y nvidia-driver-550

# Bilgisayarı yeniden başlat
sudo reboot

# Driver kontrolü
nvidia-smi
```

### CUDA Toolkit Kurulumu

```bash
# CUDA Repository Anahtarı Ekle
wget -qO - https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub | sudo apt-key add -

# Repository Ekle
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"

# CUDA Toolkit Yükle
sudo apt update
sudo apt install -y cuda-toolkit-12-4
```

### cuDNN Kurulumu (İsteğe Bağlı)

```bash
# NVIDIA Geliştirici Hesabı ile indirin
# https://developer.nvidia.com/cudnn

# Tarball'ı açın
tar -xzvf cudnn-linux-x86_64-8.x.x.x_cuda12-archive.tar.xz

# CUDA dizinine kopyala
sudo cp cudnn-archive/include/cudnn.h /usr/local/cuda/include/
sudo cp cudnn-archive/lib/libcudnn* /usr/local/cuda/lib64/
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
```

### GPU Kontrolü

```bash
# GPU bilgilerini göster
nvidia-smi

# Python'dan CUDA kontrolü
python3 -c "import torch; print(torch.cuda.is_available())"
```

---

## Sorun Giderme

### Docker Permission Denied

```bash
sudo usermod -aG docker $USER
newgrp docker
docker ps  # Test et
```

### UV Komut Bulunamıyor

```bash
# Shell'i yeniden başlat
source $HOME/.cargo/bin/env

# veya terminal'i kapat, yeniden aç
```

### Port 3000 Zaten Kullanımda

```bash
# Kullanılan prosesi bul
lsof -i :3000

# Prosesi öldür
kill -9 <PID>
```

### Yetersiz Disk Alanı

```bash
# Disk kullanımını kontrol et
df -h

# Docker temizle
docker system prune -a
docker volume prune
```

### CUDA Bulunamıyor

```bash
# CUDA PATH'ini kontrol et
echo $CUDA_PATH

# Path'i ekle
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

---

## Günlük İşlemler

### CodeAssist'i Manuel Başlat

```bash
cd ~/projects/codeassist
uv run run.py
```

### Service Komutları

```bash
# Servisi başlat
sudo systemctl start codeassist

# Servisi durdur
sudo systemctl stop codeassist

# Servisi yeniden başlat
sudo systemctl restart codeassist

# Durumunu kontrol et
sudo systemctl status codeassist
```

### Model Dosyaları

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

## Performans İpuçları

### Docker Bellek Sınırı

Docker daemon'ın kullandığı belleği sınırla:

```bash
mkdir -p ~/.docker
echo '{
  "storage-driver": "overlay2",
  "max-concurrent-downloads": 5
}' | tee ~/.docker/daemon.json

sudo systemctl restart docker
```

### CPU Kullanımı Optimizasyonu

```bash
# CPU çekirdek sayısını kontrol et
grep -c ^processor /proc/cpuinfo

# Container CPU kullanımını sınırla
docker update --cpus="2.0" <container_id>
```

---

*Son Güncelleme: 17 Kasım 2025*
