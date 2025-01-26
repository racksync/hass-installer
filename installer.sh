# ASCII art text
echo -e "${YELLOW}"
echo "  _    _           _____ _____                                          "
echo " | |  | |   /\    / ____/ ____|                                         "
echo " | |__| |  /  \  | (___| (___                                           "
echo " |  __  | / /\ \  \___ \\___ \                                          "
echo " | |  | |/ ____ \ ____) |___) |                                         "
echo " |_|__|_/_/ _  \_\_____/_____/     _      _      ______ _____           "
echo " |_   _| \ | |/ ____|__   __|/\   | |    | |    |  ____|  __ \          "
echo "   | | |  \| | (___    | |  /  \  | |    | |    | |__  | |__) |         "
echo "   | | | . \` |\___ \   | | / /\ \ | |    | |    |  __| |  _  /          "
echo "  _| |_| |\  |____) |  | |/ ____ \| |____| |____| |____| | \ \          "
echo " |_____|_| \_|_____/_  |_/_/    \_\______|______|______|_|__\_\_  _____ "
echo " | |           |  __ \     /\   / ____| |/ // ____\ \   / / \ | |/ ____|"
echo " | |__  _   _  | |__) |   /  \ | |    | ' /| (___  \ \_/ /|  \| | |     "
echo " | '_ \| | | | |  _  /   / /\ \| |    |  <  \___ \  \   / | . \` | |     "
echo " | |_) | |_| | | | \ \  / ____ \ |____| . \ ____) |  | |  | |\  | |____ "
echo " |_.__/ \__, | |_|  \_\/_/    \_\_____|_|\_\_____/   |_|  |_| \_|\_____|"
echo "         __/ |                                                          "
echo "        |___/                                                           "
echo -e "${NC}"

# Information about the script
echo -e "${YELLOW}🚀 Welcome to the RACKSYNC HASS INSTALLER 2025.1.1 ${NC}"
echo -e "${YELLOW}This script makes it easier to install Home Assistant Supervised on Debian.${NC}"
echo -e "${YELLOW}Features include:${NC}"
echo -e "${YELLOW}- 🛠️ Automated installation of all necessary dependencies.${NC}"
echo -e "${YELLOW}- 🌐 Configuration of NetworkManager for better network management.${NC}"
echo -e "${YELLOW}- 🐳 Installation of Docker, OS Agent, and Home Assistant Supervised.${NC}"
echo -e "${YELLOW}- 📋 Simplified process with prompts and error handling.${NC}"

# Define pause function
pause() {
  read -p "Press any key to continue..."
}

# Pause before starting the first process
pause

# Define check_error function
check_error() {
  if [ $? -ne 0 ]; then
    echo -e "${RED}$1${NC}"
    exit 1
  fi
}

# Define the select_architecture function
select_architecture() {
  echo -e "${YELLOW}Select your architecture:${NC}"
  echo "1) amd64"
  echo "2) aarch64"
  echo "3) arm64"
  echo "4) armv5"
  echo "5) armv6"
  echo "6) armv7"
  echo "7) i386"
  echo "8) x86_64"
  read -p "Enter your choice [1-8]: " arch_choice

  case $arch_choice in
      1)
        ARCH="amd64"
        ;;
      2)
        ARCH="aarch64"
        ;;
      3)
        ARCH="arm64"
        ;;
      4)
        ARCH="armv5"
        ;;
      5)
        ARCH="armv6"
        ;;
      6)
        ARCH="armv7"
        ;;
      7)
        ARCH="i386"
        ;;
      8)
        ARCH="x86_64"
        ;;
      *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
  esac
}

# Add hostname change option
change_hostname() {
  read -p "Enter the desired hostname (default: homeassistant.local): " new_hostname < /dev/tty
  new_hostname=${new_hostname:-homeassistant.local}
  echo -e "${YELLOW}Changing hostname to ${new_hostname}...${NC}"
  hostnamectl set-hostname "$new_hostname"
  check_error "Failed to change hostname"
  echo -e "${GREEN}Hostname changed to ${new_hostname} successfully.${NC}"
}

# Update and upgrade system
echo -e "${YELLOW}Updating and upgrading the system...${NC}"
apt update && apt upgrade -y
check_error "Failed to update and upgrade the system"
echo -e "${GREEN}System updated and upgraded successfully.${NC}"
pause

# Install dependencies
echo -e "${YELLOW}Installing required dependencies...${NC}"
apt install -y apparmor bluez cifs-utils curl dbus jq libglib2.0-bin lsb-release network-manager nfs-common systemd-journal-remote systemd-resolved udisks2 wget -y
check_error "Failed to install required dependencies"
echo -e "${GREEN}Dependencies installed successfully.${NC}"

# Update NetworkManager configuration
echo -e "${YELLOW}Updating NetworkManager configuration...${NC}"
sed -i 's/managed=false/managed=true/' /etc/NetworkManager/NetworkManager.conf
check_error "Failed to update NetworkManager configuration"
echo -e "${GREEN}NetworkManager configuration updated successfully.${NC}"
pause

# Ensure Docker is installed
echo -e "${YELLOW}Checking Docker installation...${NC}"
if ! docker --version &> /dev/null; then
  echo -e "${YELLOW}Docker not found. Installing Docker...${NC}"
  apt-get update
  check_error "Failed to update package list"
  apt-get install -y apt-transport-https ca-certificates curl software-properties-common
  check_error "Failed to install prerequisites"
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
  check_error "Failed to add Docker GPG key"
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
  check_error "Failed to add Docker repository"
  apt-get update
  check_error "Failed to update package list after adding Docker repository"
  apt-get install -y docker-ce
  check_error "Failed to install Docker"
  echo -e "${YELLOW}Verifying Docker installation...${NC}"
  if ! docker --version &> /dev/null; then
    echo -e "${RED}Docker installation failed. Exiting.${NC}"
    exit 1
  fi
  echo -e "${GREEN}Docker installed successfully.${NC}"
else
  echo -e "${GREEN}Docker is already installed.${NC}"
fi
pause

# Install OS Agent
select_architecture
change_hostname
echo -e "${YELLOW}Downloading and installing OS Agent for architecture: ${ARCH}...${NC}"
OS_AGENT_LATEST=$(curl -s https://api.github.com/repos/home-assistant/os-agent/releases/latest | jq -r --arg ARCH "$ARCH" '.assets[] | select(.name | contains($ARCH) and endswith(".deb")) | .browser_download_url')
if [ -z "$OS_AGENT_LATEST" ]; then
  echo -e "${RED}Failed to find OS Agent for architecture: ${ARCH}.${NC}"
  exit 1
fi
echo -e "${YELLOW}OS Agent download URL: $OS_AGENT_LATEST${NC}"
curl -fsSL -o os-agent.deb "$OS_AGENT_LATEST"
check_error "Failed to download OS Agent"
echo -e "${YELLOW}Installing OS Agent...${NC}"
dpkg -i os-agent.deb
check_error "Failed to install OS Agent"
echo -e "${GREEN}OS Agent installed successfully.${NC}"
rm -f os-agent.deb
pause

# Download the Home Assistant Supervised installer
echo -e "${YELLOW}Downloading Home Assistant Supervised installer...${NC}"
INSTALLER_URL="https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb"
INSTALLER_FILE="homeassistant-supervised.deb"
echo -e "${YELLOW}Installer URL: $INSTALLER_URL${NC}"
curl -fsSL -o $INSTALLER_FILE $INSTALLER_URL
check_error "Failed to download Home Assistant Supervised installer"
echo -e "${GREEN}Installer downloaded successfully.${NC}"
pause

# Make the installer executable
echo -e "${YELLOW}Making the installer executable...${NC}"
chmod +x $INSTALLER_FILE
check_error "Failed to make the installer executable"
echo -e "${GREEN}Installer is now executable.${NC}"
pause

# Install Home Assistant Supervised
echo -e "${YELLOW}Installing Home Assistant Supervised...${NC}"
dpkg -i $INSTALLER_FILE
check_error "Home Assistant Supervised installation failed"
echo -e "${GREEN}Home Assistant Supervised installed successfully.${NC}"
pause

# Clean up the installer file
echo -e "${YELLOW}Cleaning up the installer file...${NC}"
rm -f $INSTALLER_FILE
check_error "Failed to remove the installer file"
echo -e "${GREEN}Installer file removed successfully.${NC}"
pause

# Final message
echo -e "${GREEN}Home Assistant Supervised has been installed successfully!${NC}"

# Optional reminder for reboot
echo -e "${YELLOW}It is recommended to reboot your system for all changes to take effect.${NC}"

# Ask user to reboot
read -p "Would you like to reboot now? (y/n): " reboot_choice
if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
  echo -e "${YELLOW}Rebooting system...${NC}"
  reboot
else
  echo -e "${YELLOW}Please remember to reboot your system later for all changes to take effect.${NC}"
fi
