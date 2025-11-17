# CodeAssist Türkçe Kurulum Rehberi

CodeAssist, Gensyn AI tarafından geliştirilen ve size kişiselleştirilmiş yapay zeka asistanı oluşturmanızı sağlayan devrim niteliğinde bir araçtır. Bu rehber, CodeAssist'i kurulumundan başlayarak kullanıma kadar tüm aşamaları Türkçe olarak açıklamaktadır.

**Kaynak:** [Gensyn CodeAssist Docs](https://docs.gensyn.ai/testnet/codeassist/using-codeassist)

---

## İçindekiler

1. [CodeAssist Nedir?](#codeassist-nedir)
2. [Sistem Gereksinimleri](#sistem-gereksinimleri)
3. [Platform Seçimine Göre Kurulum](#platform-seçimine-göre-kurulum)
4. [Başlangıç ve Giriş](#başlangıç-ve-giriş)
5. [CodeAssist Kullanımı](#codeassist-kullanımı)
6. [Model Eğitimi](#model-eğitimi)
7. [Best Practices](#best-practices)
8. [Sorun Giderme](#sorun-giderme)

---

## CodeAssist Nedir?

CodeAssist, geleneksel kod asistanlarından farklı olarak çalışır:

- **Doğrudan Yazma:** Öneriler sunmaz, doğrudan editör içine kod yazar
- **Eğitim Sinyalleri:** Yazarken, düzeltirken veya sildiğiniz tüm eylemler, asistanı eğitir
- **Kişiselleşme:** Her kullanıcının tarzına özel bir model oluşturur
- **İşbirlikçi:** Agent veya otomatik tamamlama değil, gerçek bir işbirliğin simülasyonu

### Nasıl Çalışır?

CodeAssist iki koordine edilmiş model kullanır:

1. **Qwen2.5 Dil Modeli:** Kod düzenlemeleri, yorumlar ve çözüm adımları önerir
2. **Eğitilebilir Aksiyon Modeli:** Sizin eylemlerin ve geri bildiriminize göre öğrenir

**Önemli:** Siz bir asistan eğitiyorsunuz, sadece bir araçla konuşmuyorsunuz!

---

## Sistem Gereksinimleri

### Minimum Gereksinimler

- **İşletim Sistemi:**
  - Windows 10/11 (WSL2 ile)
  - Ubuntu 22.04+ (Linux)
  - macOS 10.14+ (Intel & Apple Silicon)

- **Yazılım:**
  - Python 3.10+
  - Docker & Docker Desktop
  - Git
  - UV (Python package manager)

- **Donanım:**
  - İşlemci: Dual-core 2.0 GHz+
  - RAM: Minimum 8GB (16GB önerilir)
  - Disk: 20GB boş alan

### İsteğe Bağlı (GPU Hızlandırması)

Daha hızlı eğitim için NVIDIA GPU kullanabilirsiniz:

- **NVIDIA GPU:** RTX 3090, 4090, 5090, A100, H100
- **CUDA:** 12.4+
- **NVIDIA Drivers:** En güncel sürüm

---

## Platform Seçimine Göre Kurulum

### Windows (WSL2)

#### 1. WSL2 Kurulumu

PowerShell'i yönetici olarak açın ve şu komutu çalıştırın:

```powershell
wsl --install
```

Bilgisayarı yeniden başlatın.

#### 2. Ubuntu 22.04 Kurulumu

```powershell
wsl --install -d Ubuntu-22.04
wsl -s Ubuntu-22.04
```

#### 3. WSL Ortamında Bağımlılıklar

WSL terminalini açın ve şu komutu çalıştırın:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3.11 python3.11-venv curl docker.io
```

#### 4. UV Kurulumu

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

#### 5. Docker WSL Entegrasyonu

Windows tarafında Docker Desktop'ı indirin: [docker.com](https://www.docker.com/)

Kurulumdan sonra Docker Desktop ayarlarında **WSL2** seçeneğini etkinleştirin.

#### 6. CodeAssist Deposu

```bash
git clone https://github.com/gensyn-ai/codeassist.git
cd codeassist
```

### Linux (Ubuntu 22.04+)

#### 1. Sistem Güncellemesi

```bash
sudo apt update && sudo apt upgrade -y
```

#### 2. Bağımlılıklar

```bash
sudo apt install -y python3.11 python3.11-venv python3-pip curl
```

#### 3. Docker Kurulumu

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
newgrp docker
```

#### 4. UV Kurulumu

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

#### 5. CodeAssist Deposu

```bash
git clone https://github.com/gensyn-ai/codeassist.git
cd codeassist
```

### macOS (Intel & Apple Silicon)

#### 1. Homebrew (Eğer kurulu değilse)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 2. Gerekli Paketler

```bash
brew install python@3.11 git
```

#### 3. Docker Desktop

[Docker Desktop for Mac](https://www.docker.com/products/docker-desktop) indir ve kur.

#### 4. UV Kurulumu

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

#### 5. CodeAssist Deposu

```bash
git clone https://github.com/gensyn-ai/codeassist.git
cd codeassist
```

---

## Başlangıç ve Giriş

### Adım 1: İlk Başlatma

CodeAssist klasörü içinde şu komutu çalıştırın:

```bash
uv run run.py
```

Bu komut:
- Yerel Docker ortamını başlatır
- Web sunucusunu `localhost:3000` adresinde çalıştırır
- Tarayıcıda otomatik olarak açar

### Adım 2: Giriş

Web arayüzü açıldığında bir giriş sayfası göreceksiniz:

**İki seçeneğiniz var:**

1. **Email ile Giriş:** Email adresine bir kerelik kod (OTP) gönderilir
2. **Google ile Giriş:** Google hesabıyla doğrudan giriş yapın

### Adım 3: İlk Giriş Sonrası

İlk girişten sonra, `persistent-data/auth/userKeyMap.json` dosyası otomatik olarak oluşturulur. Bu dosya yerel kimlik doğrulama verilerinizi saklar.

---

## CodeAssist Kullanımı

### Episode Nedir?

CodeAssist her kez başlattığınızda bir **episode** kaydı başlar:
- Tüm tıklamalar
- Tuş vuruşları
- Düzenlemeler
- Silmeler
- Kabuller

Bu tüm eylemler, kaydın bitişinden sonra eğitim sinyali olarak kullanılır.

### Problemleri Seçmek

Sol panelinde **Zorluk Seviyesi** seçin:

- **Kolay:** Başlangıçlar için ideal
- **Orta:** Temel veri yapıları ve algoritmalar
- **Zor:** Karmaşık problemler

**Shuffle Butonu:** Aynı zorluk seviyesinde başka problem alır.

### Kodlama Davranışı

#### Asistan İnteraksiyonu

Siz yazmayı durdurduğunuzda, asistan:
1. Kod üretebilir
2. Varolan kodu refactor edebilir
3. Yorum ekleyebilir
4. Hiçbir şey yapamaz (No-Op)

**No-Op Ne Demek?**

Asistan kendinden emin değilse hiçbir şey yapmaz. Bu normal ve tasarlanan bir davranıştır. Siz bir tuş vurun veya düzenleme yapın, asistan devam eder.

#### Asistanın Ürettiği Kodu Yönetme

Asistan kod yazarsa, dört seçeneğiniz vardır:

1. **Kodunu Bırak:** Olduğu gibi kalsın
2. **Düzelt/Refactor Et:** Gerekli değişiklikleri yap
3. **Satırları Sil:** İstemediğiniz parçaları kaldır
4. **Yeniden Düzenle:** Indent ve konumu ayarla

**İpucu:** Eğer hemen her şeyi silerseniz, asistan "pasif" olmayı öğrenir. Davranışı "yavaş yavaş" düzeltmek daha etkilidir.

#### Duraklatma (Pause)

Asistanı geçici olarak duraklatmak için:

- **Klavye:** `Shift + Space`
- **UI:** "Pause Assistant" butonuna tıklayın

Tekrar başlamak için herhangi bir tuş verin veya tıklayın.

#### İmleç Konumu (Cursor Awareness)

CodeAssist, imlecin konumuna göre kod ekler:

- İmleç dosya sonundaysa ve indent yoksa, kod yanlış hizalanabilir
- **Çözüm:** İmleci çalıştığınız bölüme yakın tutun
- `Tab` ve `Shift+Tab` ile indenti ayarlayın

### Test Etme

Çözümünüzü test etmek için:

1. **"Submit Solution" butonuna tıklayın**
2. **Sonuçları kontrol edin:**
   - ✓ **Doğru:** Başarı mesajı göreceksiniz
   - ✗ **Yanlış:** Hata mesajı ve test sonuçları göreceksiniz

Test sonuçlarında göreceksiniz:
- Girdi (Input)
- Standart çıktı (Stdout)
- Beklenen sonuç (Output)
- Hata mesajları

---

## Model Eğitimi

### Episode Tamamlama

Episode kaydını bitirmek ve modelinizi eğitmek için:

```bash
Ctrl + C
```

**Önemli:** LeetCode problemini tamamlamış olmak gerekmez. İstediğiniz zaman `Ctrl + C` ile durabilirsiniz.

### Eğitim Süreci

Eğitim sırasında CodeAssist:

1. Sizin düzenlemelerinizi asistanın eylemlerinin karşılaştırır
2. Geri bildiriminize göre ödül ve ceza hesaplar
3. Yerel model kontrol noktasını günceller
4. Yeni model ağırlıklarını `~/.codeassist/models` klasöründe saklar
5. (İsteğe bağlı) Modelinizi Hugging Face'e yükler

**Eğitim Süresi:** Sistem özelliklerine bağlı olarak 5-15 dakika

### Beklentiler

**İlk Episodlarda:**
- Model çok "sessiz" veya çok "güvenci" görünebilir
- Performans regrese edebilir (normal!)
- İlk 4-5 episode sonrası gelişim net olarak görülür

**İpucu:** Hızlı gelişim için 5+ farklı problemde eğitim yapın.

### Tekrar Başlatma

Eğitim bittikten sonra CodeAssist'i yeniden başlatabilirsiniz:

```bash
uv run run.py
```

Yeni model ağırlıklarınız otomatik olarak yüklenecek.

---

## Best Practices

### ✅ Yapınız

1. **CodeAssist'i İşbirlikçi Olarak Düşünün**
   - Agent olarak değil, kişisel asistan olarak
   - Sabırlı ve işbirliğine açık olmaya çalışın

2. **Normal Kodlamaya Devam Edin**
   - Asistanı doğal olarak ortaya çıkmasına izin verin
   - Yapay durumlar yaratmaya çalışmayın

3. **İyi Davranışı Ödüllendir**
   - Yeterince iyi kod en az 1 dakika beklesin
   - Sonra düzenleyin veya silin

4. **Rahatlamaya Çalışın**
   - Bu deneysel araştırma, sınav değil
   - Yanlışlar normaldir ve öğrenme fırsatıdır

5. **Çeşitli Problemler Çözün**
   - 5+ farklı problem türü = daha iyi eğitim
   - Çeşit asistanı daha esnek yapar

### ❌ Yapmayınız

1. **Her Üretimi Hemen Silmeyin**
   - Bu asistanı "pasif" olmaya teşvik eder
   - "İyi, yeterli" davranışı ödüllendir

2. **Sorunu End-to-End Çözmesini Beklemeyin**
   - Şu anda bu mümkün değil
   - Sadece yardımcı bir "çift programcı"

3. **Tamamen Pasif Oturmayın**
   - Asistan sizden geri bildirim bekler
   - Etkileşim = eğitim

4. **Hatalardan Panik Yapmayın**
   - Beklenebilir bir davranış
   - Düzeltme sinyalleri eğitim verir

---

## Sorun Giderme

### Docker Bulunamıyor

**Hata:**
```
docker: command not found
```

**Çözüm:**

**Windows/WSL:**
```bash
sudo apt install -y docker.io
sudo service docker start
```

**Linux:**
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

**macOS:**
```bash
brew install docker
```

### Python Sürümü Uyuşmazlığı

**Hata:**
```
Python 3.10+ gerekli
```

**Çözüm:**

```bash
python3.11 --version
uv python install 3.11
```

### Docker Daemon'u Çalışmıyor

**Windows/macOS:** Docker Desktop'ı başlatın

**Linux:**
```bash
sudo service docker start
# veya
sudo systemctl start docker
```

### Port 3000 Kullanımda

**Hata:**
```
Port 3000 already in use
```

**Çözüm:**

```bash
# Kullanılan prosesi bulun
lsof -i :3000

# Prosesi öldürün (Linux/macOS)
kill -9 <PID>

# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### GPU Algılanması

**NVIDIA GPU'ları algılanması için:**

```bash
# NVIDIA Drivers kontrol edin
nvidia-smi

# CUDA Toolkit yüklü mü kontrol edin
cd ~/.codeassist && python -c "import torch; print(torch.cuda.is_available())"
```

### Model Eğitimi Başarısız

**Çözüm:**
1. Disk alanını kontrol edin: `df -h`
2. RAM yeterli mi: `free -h`
3. Log dosyasını kontrol edin: `~/.codeassist/logs/`

### Web UI Açılmıyor

**Çözüm:**
```bash
# Tarayıcıda manuel olarak açın
https://localhost:3000

# Veya Docker loglarını kontrol edin
docker logs codeassist
```

---

## İleri Kullanım

### Hugging Face Entegrasyonu

Modelinizi Hugging Face'e yüklemek için:

1. Hugging Face hesabı oluşturun: [huggingface.co](https://huggingface.co)
2. Access token alın: Settings > Access Tokens
3. CodeAssist'e token'ı yapıştırın
4. Episode tamamlandığında otomatik yüklenir

### Özel Problem Ekleme

**Gelecek Özellik:** CodeAssist çok yakında özel problem eklemeyi destekleyecek.

### Multi-Node Setup

**Gelişmiş:** Birden fazla makine üzerinde dağıtılmış eğitim mümkün. Ayrıntılar için:
- GitHub Issues: [gensyn-ai/codeassist](https://github.com/gensyn-ai/codeassist/issues)
- Discord: [Gensyn Community](https://discord.com/invite/gensyn)

---

## Kaynaklar

- 📚 [Resmi Dokumentasyon](https://docs.gensyn.ai/testnet/codeassist/)
- 🎬 [Video Rehberi](https://docs.gensyn.ai/testnet/codeassist/using-codeassist#video-walkthrough)
- 💬 [Discord Topluluğu](https://discord.com/invite/gensyn)
- 🐛 [GitHub Issues](https://github.com/gensyn-ai/codeassist/issues)
- 🚀 [RL-Swarm Node Çalıştırmak](https://github.com/gensyn-ai/rl-swarm)

---

## Lisans

Bu rehber MIT Lisansı altında yayımlanmıştır.

**Katkıda Bulunabilirsiniz:** 
Hatalar, eksiklikler veya iyileştirmeler için Pull Request gönderin!

---

*Son Güncelleme: 17 Kasım 2025*
