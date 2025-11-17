# Katkıda Bulunma Rehberi

CodeAssist Türkçe Rehberi'ne katkı vermek istiyorsan, bu rehberi oku.

---

## Başlamadan Önce

- Repo'yu fork et
- Dil: **Türkçe** (teknik terimler İngilizce kalabilir)
- Hata varsa issue aç veya PR gönder

---

## Yazım Kuralları

### Dil Stili

✅ **Yap:**
- Konuşma dilinde, resmi ama anlaşılır
- "sen" adreslemesi kullan
- Aktif ses kullan

❌ **Yapma:**
- Robotik/otomatik çeviri
- "ben" veya "biz" adreslemesi
- Pasif ses aşırı

### Teknik Terimler

**İngilizce kalabilir:**
- `Docker`, `Python`, `GPU`, `NVIDIA`
- `Qwen2.5`, `LeetCode`, `CodeAssist`
- `node`, `cluster`, `episode`

**Türkçe çevrilir:**
- "Installation" → "Kurulum"
- "Requirements" → "Gereksinimler"
- "Troubleshooting" → "Sorun Giderme"

---

## Dosya Yapısı

```
.
├── README.md                 # Ana kurulum rehberi
├── SORUN-GIDERME.md         # Yaygın sorunlar
├── CONTRIBUTING.md          # Bu dosya
├── LICENSE                  # MIT License
├── docs/
│   ├── windows-wsl-kurulum.md
│   ├── linux-kurulum.md
│   └── macos-kurulum.md
└── scripts/
    ├── install-ubuntu.sh
    └── install-windows.ps1
```

---

## Katkı Türleri

### 1. Hata Düzeltme

```markdown
## Hata Başlığı

- Açıklama
- Çözüm
- Test edildi mi?
```

### 2. Yeni Bölüm Ekleme

```markdown
## Yeni Başlık

### Alt Başlık

Detaylı açıklama...

**Kod örneği:**
\`\`\`bash
komut
\`\`\`
```

### 3. Belgelendirme

- Yazım hatalarını düzelt
- Yapıyı iyileştir
- Örnekleri güncelleştir

---

## PR Göndermek

### Adım 1: Fork ve Branch

```bash
git clone https://github.com/SENIN-KULLANICI-ADIN/codeassist-turkce-kurulum-rehberi.git
cd codeassist-turkce-kurulum-rehberi
git checkout -b fix/hata-adi
```

### Adım 2: Değişiklikleri Yap

```bash
# Değişiklikleri ekle
git add .

# Commit et
git commit -m "fix: açıklaması"
```

### Adım 3: Push ve PR

```bash
git push origin fix/hata-adi
```

GitHub'da Pull Request oluştur:
- **Başlık:** Kısa ve açıklayıcı
- **Açıklama:** Ne değişti, neden?
- **Type:** fix, docs, feature

---

## Commit Mesaj Formatı

```
<type>: <başlık>

<detaylı açıklama>

Fixes #<issue_number>
```

**Type seçenekleri:**
- `fix:` Hata düzeltmesi
- `docs:` Belgelendirme
- `feature:` Yeni özellik
- `refactor:` Yapı iyileştirmesi

**Örnek:**
```
docs: WSL kurulum adımlarını güncelle

- DNS hatasını çöz
- GPU kurulumunu detaylandır
- Sorun giderme bölümü ekle

Fixes #15
```

---

## Kod Blokları

### Bash

```bash
# Yorum
sudo apt install -y package
```

### PowerShell

```powershell
# Yorum
wsl --install -d Ubuntu-22.04
```

### Python

```python
# Yorum
import torch
print(torch.cuda.is_available())
```

---

## Önemli Noktalar

✅ **Kontrol Et:**
- [ ] Yazım hataları yok mu?
- [ ] Komutlar test edildi mi?
- [ ] Linkler çalışıyor mu?
- [ ] Türkçe doğru mu?
- [ ] Versiyonlar güncel mi?

❌ **Hatalıklardan Kaç:**
- Otoçevirinin robotik çevirilerini
- Özelleme ("ben yaptım", "biz yaptık")
- Yanlış/eski bilgiler
- Eksik kurulum adımları

---

## Ödül

Her katkı için:
- ⭐ Repository'de mention
- 🎉 Contributors listesine ekleme
- 🏆 Ana sayfada isim ve link

---

## Sorular?

- GitHub Issues aç
- Discord'dan sor: [Gensyn Community](https://discord.com/invite/gensyn)
- Doğrudan PR yap

---

**Teşekkürler katkılarından! 🙏**

*Son Güncelleme: 17 Kasım 2025*
