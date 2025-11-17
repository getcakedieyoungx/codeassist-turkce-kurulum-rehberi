# CodeAssist Türkçe Kurulum Rehberi

![GitHub](https://img.shields.io/badge/GitHub-Repo-blue)
![License MIT](https://img.shields.io/badge/License-MIT-green)
![Language Turkish](https://img.shields.io/badge/Language-T%C3%BCrk%C3%A7e-red)
![Status Complete](https://img.shields.io/badge/Status-Complete-success)

🌐 **Türkçe Kurulum Rehberi** | CodeAssist için kapsamlı Türkçe dokumentasyon

---

## 🚀 Başlayın

**CodeAssist** Gensyn AI tarafından geliştirilen devrim niteliğinde bir araçtır. Bu rehber, kurulumundan başlayarak kullanıma kadar tüm aşamaları Türkçe olarak açıklar.

### ⚡ Hızlı Başlangıç

**Otomatik Kurulum (Linux):**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/getcakedieyoungx/codeassist-turkce-kurulum-rehberi/main/scripts/install-ubuntu.sh)
```

**Otomatik Kurulum (Windows WSL2):**
```powershell
IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/getcakedieyoungx/codeassist-turkce-kurulum-rehberi/main/scripts/install-windows.ps1')
```

**Manuel Kurulum:**
1. [Ana Rehber](./README.md)'i oku
2. İşletim sisteminiz için kurulum adımlarını takip et
3. `uv run run.py` ile başlat

---

## 📚 Rehberler

### Platform Seçin

| Platform | Rehber | Durum |
|----------|--------|-------|
| 🪟 Windows (WSL2) | [Detaylı Rehber](./docs/windows-wsl-kurulum.md) | ✅ Tamamlandı |
| 🐧 Linux (Ubuntu) | [Detaylı Rehber](./docs/linux-kurulum.md) | ✅ Tamamlandı |
| 🍎 macOS (Intel/ARM) | [Detaylı Rehber](./docs/macos-kurulum.md) | ✅ Tamamlandı |

### Konular

- 📖 [**README.md**](./README.md) - Ana kurulum rehberi, sistem gereksinimleri, temel kullanım
- 🔧 [**SORUN-GIDERME.md**](./SORUN-GIDERME.md) - Yaygın sorunlar ve çözümleri
- 🤝 [**CONTRIBUTING.md**](./CONTRIBUTING.md) - Katkıda bulunma rehberi
- ⚙️ [**scripts/**](./scripts/) - Otomatik kurulum scriptleri

---

## 🎯 Özellikleri

✅ **Kapsamlı Türkçe Dokümantasyon**
- Tüm kurulum adımları Türkçe
- Teknik terimler korunur, açıklama Türkçe
- Doğal, anlaşılır dil

✅ **Platform Desteği**
- Windows 10/11 (WSL2)
- Ubuntu 22.04+ (Linux)
- macOS 10.14+ (Intel & Apple Silicon)

✅ **Otomatik Kurulum Scriptleri**
- Linux bash script
- Windows PowerShell script
- Tek komutla tamamlama

✅ **Ayrıntılı Sorun Giderme**
- 20+ yaygın sorun ve çözüm
- GPU yapılandırması
- Docker/Sistem sorunları

---

## 📋 Sistem Gereksinimleri

### Minimum
- **İşletim Sistemi:** Windows 10/11, Ubuntu 22.04+, macOS 10.14+
- **RAM:** 8GB (16GB önerilir)
- **Disk:** 20GB boş alan
- **Python:** 3.10+
- **Docker & Git**

### İsteğe Bağlı (GPU Hızlandırması)
- NVIDIA GPU (RTX 3090, 4090, A100)
- CUDA 12.4+
- cuDNN

---

## 🚀 CodeAssist Nedir?

### Geleneksel Asistanlardan Farkı

❌ **Geleneksel:** Öneri sunup sen kabul/red et

✅ **CodeAssist:** Doğrudan kod yaz, sen tepki ver

### İş Modeli

1. **Asistan yazıyor** → Kod üretir
2. **Sen etkileşim kuruyor** → Kabul/red/değiştir
3. **Model öğreniyor** → Senin tarzına adapte ol
4. **Tekrarlıyor** → Daha iyi hale gel

> **Sonuç:** Kişiseline hale getirilmiş AI asistan!

---

## 💡 Hızlı Örnekler

### LeetCode Problemi Çöz

```bash
cd ~/projects/codeassist
uv run run.py
# Tarayıcı açılacak: http://localhost:3000

# 1. Giriş yap
# 2. Problem seç (Kolay/Orta/Zor)
# 3. Kodla (asistan yardımcı olacak)
# 4. Ctrl + C ile bitir
# 5. Model eğitilecek
```

### Model Kalitesi

- **İlk 1-2 Episode:** "Sessiz" olabilir (normal)
- **3-5 Episode sonra:** Gözle görülür iyileşme
- **10+ Episode:** Çok iyi personalize model

---

## 🤝 Katkıda Bulun

**Hataları düzelt, rehberleri genişlet!**

```bash
# Fork → Branch → PR
git clone https://github.com/SENIN-KULLANICI-ADIN/codeassist-turkce-kurulum-rehberi.git
git checkout -b fix/hata-adi
# Değişiklikleri yap
git commit -m "fix: açıklama"
git push origin fix/hata-adi
# GitHub'da PR aç
```

📄 Detaylar: [CONTRIBUTING.md](./CONTRIBUTING.md)

---

## 📞 Destek

**Sorun yaşıyor musun?**

1. 📖 [Sorun Giderme Rehberi](./SORUN-GIDERME.md)'ni oku
2. 🔍 [GitHub Issues](https://github.com/gensyn-ai/codeassist/issues)'de ara
3. 💬 [Discord](https://discord.com/invite/gensyn)'da #codeassist soruştur
4. 🐛 Yeni issue aç

---

## 📚 Kaynaklar

- 🔗 [Resmi CodeAssist Docs](https://docs.gensyn.ai/testnet/codeassist/)
- 🎥 [Video Walkthrough](https://docs.gensyn.ai/testnet/codeassist/using-codeassist#video-walkthrough)
- 💻 [Gensyn GitHub](https://github.com/gensyn-ai)
- 🌐 [Discord Topluluğu](https://discord.com/invite/gensyn)
- 🚀 [RL-Swarm Node Çalıştırma](https://github.com/gensyn-ai/rl-swarm)

---

## 📄 Lisans

Bu proje **MIT Lisansı** altında yayımlanmıştır.

Serbest kullanabilirsin, değiştirebilirsin, dağıtabilirsin!

---

## 🌟 Teşekkürler

- **Gensyn AI** - CodeAssist'in yaratıcısı
- **Katkıda bulunanlar** - Bu rehberi geliştirenlere
- **Türkçe Topluluğu** - Desteği için

---

<div align="center">

**[🏠 Ana Sayfa](./README.md) • [📖 Sorun Giderme](./SORUN-GIDERME.md) • [🤝 Katkıda Bulun](./CONTRIBUTING.md)**

*Son Güncelleme: 17 Kasım 2025*

**Yıldız ver, fork et, paylaş! ⭐**

</div>
