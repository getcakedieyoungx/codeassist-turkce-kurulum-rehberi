# 🚀 30 Saniyede Başlangıç

CodeAssist'i hızlı başlatmak istiyorsan, bu rehberi takip et!

---

## 1. Otomatik Kurulum

### Linux (Ubuntu)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/getcakedieyoungx/codeassist-turkce-kurulum-rehberi/main/scripts/install-ubuntu.sh)
```

### Windows WSL2

```powershell
IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/getcakedieyoungx/codeassist-turkce-kurulum-rehberi/main/scripts/install-windows.ps1')
```

### macOS

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install python@3.11 git docker
curl -LsSf https://astral.sh/uv/install.sh | sh
```

---

## 2. CodeAssist'i Başlat

```bash
cd ~/projects/codeassist
uv run run.py
```

**Tarayıcını aç :** [http://localhost:3000](http://localhost:3000)

---

## 3. Giriş Yap

- 📧 **Email:** OTP kodu al
- 🔐 **Google:** Direkt giriş

---

## 4. Problem Seç

- ⭐ Kolay, Orta, Zor
- 🔄 Shuffle: Başka problem

---

## 5. Kodla

Asistan yardımcı olacak!

- ✅ Kabul et
- ✏️ Düzelt
- ❌ Sil
- ⏸ Duraklat: `Shift + Space`

---

## 6. Gönder ve Eğit

```bash
Ctrl + C  # Bitir ve eğit
```

Model eğitilecek ✅

---

## 7. Tekrarla

```bash
uv run run.py  # Yeniden başlat
```

Model daha iyi hale gelecek! 🚀

---

## 💉 Değil mi?

**[Sorun Giderme](./SORUN-GIDERME.md)'yi Kontrol Et**

---

## 📚 Detaylı Rehberler

- [🏠 Ana Rehber](./README.md)
- [🖥️ Windows WSL2](./docs/windows-wsl-kurulum.md)
- [🐧 Linux Ubuntu](./docs/linux-kurulum.md)
- [🍎 macOS](./docs/macos-kurulum.md)

---

**Hazır mısın? 🚀 Şimdi başla!**
