#!/bin/bash
# ------------------------------------------
# 🔧 Linux Mint Dev Environment Installer
# ------------------------------------------
# Crea un entorno de desarrollo completo
# Autor: Agustin Arriagada
# Repositorio: https://github.com/<tu_usuario>/dev-setup
# ------------------------------------------

# Verifica si el script se ejecuta como root
if [ "$EUID" -ne 0 ]; then 
  echo "❌ Por favor ejecuta con: sudo bash setup-dev.sh"
  exit 1
fi

echo "🚀 Iniciando configuración del entorno de desarrollo..."

# Actualiza repositorios
apt update && apt upgrade -y

# -----------------------------
# 🧰 Herramientas esenciales
# -----------------------------
apt install -y curl wget git build-essential apt-transport-https ca-certificates gnupg software-properties-common

# -----------------------------
# 🧠 Git & GitHub CLI
# -----------------------------
echo "📦 Instalando Git y GitHub CLI..."
apt install -y git
type -p curl >/dev/null || apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt update && apt install gh -y

# -----------------------------
# 💻 Visual Studio Code
# -----------------------------
echo "💻 Instalando Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
apt install -y apt-transport-https
apt update && apt install -y code
rm -f packages.microsoft.gpg

# -----------------------------
# ⚙️ Arduino IDE
# -----------------------------
echo "🔌 Instalando Arduino IDE..."
snap install arduino

# -----------------------------
# 🌐 Postman
# -----------------------------
echo "📮 Instalando Postman..."
snap install postman

# -----------------------------
# 🛰️ Mosquitto MQTT
# -----------------------------
echo "📡 Instalando Mosquitto Broker y cliente..."
apt install -y mosquitto mosquitto-clients
systemctl enable mosquitto
systemctl start mosquitto

# -----------------------------
# ✅ Limpieza final
# -----------------------------
apt autoremove -y
echo "✅ Instalación completa."

# -----------------------------
# 🧠 Información final
# -----------------------------
echo "-----------------------------------------------"
echo "🎉 Entorno listo!"
echo "Incluye:"
echo "  - VS Code"
echo "  - Arduino IDE"
echo "  - Postman"
echo "  - Git + GitHub CLI"
echo "  - Mosquitto MQTT Broker"
echo "-----------------------------------------------"
echo "💡 Tip: ejecuta 'gh auth login' para conectar tu cuenta de GitHub."
