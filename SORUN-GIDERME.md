# CodeAssist Sorun Giderme Rehberi

CodeAssist kullanırken yaşayabileceğiniz yaygın sorunlar ve çözümler.

---

## Kurulum Sorunları

### Docker Bulunamıyor

**Hata:**
```
command not found: docker
```

**Çözüm:**

**Windows WSL2:**
```bash
sudo apt install -y docker.io
sudo service docker start
```

**Linux:**
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

**macOS:**
```bash
brew install docker
# veya Docker Desktop'ı indir
```

---

### Python Sürümü Hatasıu

**Hata:**
```
Python 3.10+ required
Your Python version: 3.9.x
```

**Çözüm:**

```bash
# Python 3.11 yükle
sudo apt install -y python3.11

# Varsayılan yap
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Kontrol et
python3 --version
```

---

### WSL2 Çekirdek Hatası

**Hata:**
```
WSL 2 requires an update to its kernel component
```

**Çözüm:**

```powershell
# PowerShell'de (yönetici)
wsl --update
wsl --shutdown
wsl  # Yeniden başlat
```

---

### UV Kurulumu Başarısız

**Hata:**
```
curl: command not found
```

**Çözüm:**

```bash
# curl yükle
sudo apt install -y curl

# UV'yi tekrar kur
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.cargo/bin/env
```

---

## Çalıştırma Sorunları

### Port 3000 Zaten Kullanımda

**Hata:**
```
ERROR: address already in use
Port: 3000
```

**Çözüm:**

**Linux/macOS:**
```bash
# Kullanılan prosesi bul
lsof -i :3000

# Prosesi öldür
kill -9 <PID>
```

**Windows:**
```powershell
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

**Alternatif:** Farklı port kullan
```bash
DOCKER_PORT=3001 uv run run.py
```

---

### Docker Daemon Çalışmıyor

**Hata:**
```
Cannot connect to Docker daemon
socket: /var/run/docker.sock
```

**Çözüm:**

**Linux:**
```bash
sudo systemctl start docker
sudo systemctl enable docker  # Otomatik başlatma
```

**macOS:**
```bash
# Docker Desktop'ı başlat
# Applications > Docker.app
```

**WSL2:**
```bash
sudo service docker start
```

---

### Web UI Açılmıyor

**Hata:**
```
ERROR: Cannot reach http://localhost:3000
```

**Çözüm:**

1. **Browser cache temizle:**
   - Ctrl + Shift + Delete
   - Cached images & files kaldır

2. **Docker loglarını kontrol et:**
```bash
docker logs codeassist-web
```

3. **Container çalışıyor mu:**
```bash
docker ps | grep codeassist
```

4. **Manuel olarak aç:**
```
http://127.0.0.1:3000
https://localhost:3000
```

---

### "Permission denied" Hatası

**Hata:**
```
permission denied while trying to connect to the Docker daemon
```

**Çözüm:**

```bash
# Mevcut kullanıcıyı docker grubuna ekle
sudo usermod -aG docker $USER

# Grup değişikliğini uygula
newgrp docker

# Veya socket izinlerini değiştir
sudo chmod 666 /var/run/docker.sock
```

---

## Giriş ve Kimlik Doğrulama

### OTP Email Almıyorum

**Çözüm:**

1. **Spam klasörünü kontrol et**
2. **Email adresini doğru yazdığını kontrol et**
3. **5-10 dakika bekle**
4. **Yeniden dene:**
   - "Send OTP again" butonuna tıkla
   - Yeni email adresi gir

---

### Google Giriş Hatası

**Hata:**
```
Google sign-in failed
Retry
```

**Çözüm:**

1. **Browser çerezleri temizle**
2. **Farklı tarayıcı dene** (Chrome, Firefox, Safari)
3. **Özel/İnkognito modunda aç**
4. **Google hesabı kontrol et:**
   - İki faktörlü kimlik doğrulama etkinse
   - Uygulama şifresi oluştur

---

### "Invalid Token" Hatası

**Hata:**
```
UserKeyMap.json is invalid
```

**Çözüm:**

```bash
# Auth dosyasını sıfırla
rm -rf ~/.codeassist/persistent-data/auth/

# CodeAssist'i yeniden başlat
uv run run.py

# Yeniden giriş yap
```

---

## Model Eğitimi Sorunları

### Eğitim Hiç Başlamıyor

**Hata:**
```
Training seems to be stuck
```

**Çözüm:**

1. **Disk alanını kontrol et:**
```bash
df -h
# 5GB+ boş alan gerekli
```

2. **RAM yeterli mi:**
```bash
free -h
# 4GB+ boş RAM gerekli
```

3. **Model dosyalarını kontrol et:**
```bash
ls -la ~/.codeassist/models/
```

4. **Logs'a bak:**
```bash
cat ~/.codeassist/logs/latest.log | tail -50
```

---

### Eğitim Çok Yavaş

**Çözüm:**

1. **GPU'yu kullan:**
   - NVIDIA GPU yükle (RTX 3090+)
   - CUDA 12.4+ kur
   - `nvidia-smi` ile kontrol et

2. **Sistem kaynaklarını kontrol et:**
   - Diğer uygulamaları kapat
   - RAM yeterli mi?
   - İşlemci sıcaklığı normale mi?

3. **Docker kaynaklarını artır:**
```bash
# Linux
sudo docker update --memory 8g --memory-swap 8g codeassist-app

# macOS/Windows: Docker Desktop ayarlarından artır
```

---

### Model Dosyaları Kayboldu

**Çözüm:**

```bash
# Modellerin konumunu kontrol et
ls -la ~/.codeassist/models/

# Hugging Face'e yüklü versiyonu geri al
# (eğer daha önce yüklediyse)
```

**Yedekle:**
```bash
cp -r ~/.codeassist/models ~/backup-models
```

---

### "Out of Memory" Hatası

**Hata:**
```
CUDA out of memory
OOM: tried to allocate X GB
```

**Çözüm:**

1. **Batch size'ı düşür:**
   - CodeAssist config dosyasında: `batch_size = 16` → `batch_size = 8`

2. **RAM yeterli mi:**
   - Minimum 8GB (16GB önerilir)
   - Diğer uygulamaları kapat

3. **GPU belleğini temizle:**
```bash
nvidia-smi --query-compute-apps=pid --format=csv,noheader | xargs kill -9
nvidia-smi --query compute-apps=none
```

4. **Model boyutunu kontrol et:**
   - Daha hafif model kullan
   - Düşük hassasiyetli (FP16) eğitim yap

---

## GPU Sorunları

### "cuda: not found"

**Hata:**
```
ERROR: CUDA not found
```

**Çözüm:**

```bash
# CUDA Toolkit kur
sudo apt install -y nvidia-cuda-toolkit

# CUDA PATH'ini kontrol et
echo $CUDA_PATH

# El ile ekle (gerekirse)
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

---

### NVIDIA Driver Bulunam

**Hata:**
```
Failed to initialize CUDA
Driver version insufficient
```

**Çözüm:**

```bash
# Driver kontrol et
nvidia-smi

# En yeni driver'ı kur
sudo apt install -y nvidia-driver-550

# Bilgisayarı yeniden başlat
sudo reboot
```

---

### GPU Kullanılmıyor

**Kontrol et:**
```bash
nvidia-smi

# Eğitim sırasında kullanıma bak
watch -n 1 nvidia-smi
```

**Eğer 0% ise:**

1. CUDA/cuDNN yüklü mü?
2. NVIDIA Drivers güncel mi?
3. PyTorch CUDA'yı algılıyor mu?

```bash
python3 -c "import torch; print(torch.cuda.is_available())"
```

---

## Performans Sorunları

### Asistan Çok "Sessiz"

**Nedir:** Asistan hiç kod üretmiyor

**Çözüm:**
1. Normal - İlk episodlarda beklenir
2. 4-5 episode sonra iyileşir
3. Farklı problemler dene
4. Sab ırlı ve ısrarcı ol

---

### Asistan Çok "Agresif"

**Nedir:** Asistan her saniye kod yazıyor

**Çözüm:**
1. Duraklatma tuş: `Shift + Space`
2. Paused modunda kod yaz
3. Pause butonu ile kontrol et
4. Eğitim yavaş davranışı yapacaktır

---

## Disk ve Depolama

### Yetersiz Disk Alanı

**Hata:**
```
No space left on device
```

**Çözüm:**

```bash
# Disk kullanımını kontrol et
du -sh ~ | head -20

# Docker temizle
docker system prune -a --volumes

# Eski modelleri sil
rm -rf ~/.codeassist/models/old_*

# Logs temizle (eski dosyaları)
rm -f ~/.codeassist/logs/*.old
```

---

## Ağ ve Bağlantı

### "Connection refused" Hatası

**Hata:**
```
ERROR: Connection refused
Connect to: localhost:3000
```

**Çözüm:**

1. **Container çalışıyor mu:**
```bash
docker ps
```

2. **Logs kontrol et:**
```bash
docker logs codeassist-web
```

3. **Port açık mı:**
```bash
ss -tulpn | grep 3000
```

4. **Firewall kontrol et:**
   - Güvenlik duvarı Port 3000'i bloklayabilir
   - İzin ver veya başka port dene

---

## Destek ve Yardım

**Sorunun Çözülmüyor ise:**

1. **Log dosyasını topla:**
```bash
cp ~/.codeassist/logs/latest.log ~/codeassist-error.log
```

2. **GitHub Issue aç:**
   - [gensyn-ai/codeassist/issues](https://github.com/gensyn-ai/codeassist/issues)
   - Error log'u ekle
   - Sistem bilgini ekle: `uname -a`, `python --version`, `docker --version`

3. **Discord'a sor:**
   - [Gensyn Community](https://discord.com/invite/gensyn)
   - #codeassist kanalı
   - Detaylı sorunun açıklamasını yaz

---

*Son Güncelleme: 17 Kasım 2025*
