#!/bin/bash
# CodeAssist Ubuntu Kurulum Scripti
# Bu script, Ubuntu 22.04+ üzerinde CodeAssist'i otomatik olarak kurar

set -e  # Hata olursa dur

# Renkli çıktı için
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'  # No Color

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}CodeAssist Ubuntu Kurulum Scripti${NC}"
echo -e "${BLUE}=====================================${NC}\n"

# 1. Sistem Güncellemesi
echo -e "${YELLOW}[1/7]${NC} Sistem güncelleniyor..."
sudo apt update
sudo apt upgrade -y

# 2. Temel Araçlar
echo -e "${YELLOW}[2/7]${NC} Temel araçlar yükleniyor..."
sudo apt install -y \
  build-essential \
  curl \
  wget \
  git \
  python3.11 \
  python3.11-dev \
  python3-pip

# 3. Python Varsayılan Yapma
echo -e "${YELLOW}[3/7]${NC} Python 3.11 varsayılan yapılıyor..."
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# 4. Docker
echo -e "${YELLOW}[4/7]${NC} Docker yükleniyor..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
rm get-docker.sh

# 5. UV Package Manager
echo -e "${YELLOW}[5/7]${NC} UV Package Manager yükleniyor..."
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.cargo/bin:$PATH"

# 6. CodeAssist Deposu
echo -e "${YELLOW}[6/7]${NC} CodeAssist deposu klonlanıyor..."
mkdir -p ~/projects
cd ~/projects
if [ ! -d "codeassist" ]; then
  git clone https://github.com/gensyn-ai/codeassist.git
fi
cd codeassist

# 7. Docker Socket Izinleri
echo -e "${YELLOW}[7/7]${NC} Docker socket izinleri ayarlanıyor..."
sudo chmod 666 /var/run/docker.sock 2>/dev/null || true

echo -e "\n${GREEN}✓ Kurulum başarıyla tamamlandı!${NC}\n"

echo -e "${BLUE}Sonraki adımlar:${NC}"
echo -e "${BLUE}1.${NC} Terminal'i kapatıp yeniden aç (docker grubu değişikliği için)"
echo -e "${BLUE}2.${NC} CodeAssist dizinine git: ${YELLOW}cd ~/projects/codeassist${NC}"
echo -e "${BLUE}3.${NC} CodeAssist'i başlat: ${YELLOW}uv run run.py${NC}"
echo -e "${BLUE}4.${NC} Tarayıcıda aç: ${YELLOW}http://localhost:3000${NC}\n"

echo -e "${GREEN}Mutlu kodlamalar! 🚀${NC}"
