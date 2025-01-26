#!/bin/bash

# Information about the script
echo -e "${YELLOW}🚀 Welcome to the RACKSYNC HASS UNINSTALLER 2025.1.1 ${NC}"
echo -e "${YELLOW}This script makes it easier to uninstall Home Assistant Supervised on Debian.${NC}"

# Define check_error function
check_error() {
  if [ $? -ne 0 ]; then
    echo -e "${RED}$1${NC}"
    return 1
  fi
  return 0
}

# Define pause function
pause() {
  read -p "Press any key to continue..."
}

# Initialize report
report=""

# Stop and remove all Docker containers
echo -e "${YELLOW}Stopping and removing all Docker containers...${NC}"
containers=$(docker ps -aq)
if [ -z "$containers" ]; then
  echo -e "${YELLOW}No Docker containers found.${NC}"
  pause
else
  docker stop $containers
  if check_error "Failed to stop Docker containers"; then
    docker rm $containers
    if check_error "Failed to remove Docker containers"; then
      report+="\e[32m[x] Docker containers: succeed\e[0m\n"
    else
      report+="\e[31m[x] Docker containers: failed\e[0m\n"
    fi
  else
    report+="\e[31m[x] Docker containers: failed\e[0m\n"
  fi
  pause
fi

# Remove all Docker images
echo -e "${YELLOW}Removing all Docker images...${NC}"
images=$(docker images -q)
if [ -z "$images" ]; then
  echo -e "${YELLOW}No Docker images found.${NC}"
  pause
else
  docker rmi -f $images
  if check_error "Failed to remove Docker images"; then
    report+="\e[32m[x] Docker images: succeed\e[0m\n"
  else
    report+="\e[31m[x] Docker images: failed\e[0m\n"
  fi
  pause
fi

# Remove all Docker volumes
echo -e "${YELLOW}Removing all Docker volumes...${NC}"
volumes=$(docker volume ls -q)
if [ -z "$volumes" ]; then
  echo -e "${YELLOW}No Docker volumes found.${NC}"
  pause
else
  docker volume rm $volumes
  if check_error "Failed to remove Docker volumes"; then
    report+="\e[32m[x] Docker volumes: succeed\e[0m\n"
  else
    report+="\e[31m[x] Docker volumes: failed\e[0m\n"
  fi
  pause
fi

# Remove Home Assistant Supervised
echo -e "${YELLOW}Removing Home Assistant Supervised...${NC}"
dpkg --purge homeassistant-supervised
if check_error "Failed to remove Home Assistant Supervised"; then
  report+="\e[32m[x] Home Assistant Supervised: succeed\e[0m\n"
else
  report+="\e[31m[x] Home Assistant Supervised: failed\e[0m\n"
fi
pause

# Remove OS Agent
echo -e "${YELLOW}Removing OS Agent...${NC}"
dpkg --purge os-agent
if check_error "Failed to remove OS Agent"; then
  report+="\e[32m[x] OS Agent: succeed\e[0m\n"
else
  report+="\e[31m[x] OS Agent: failed\e[0m\n"
fi
pause

# Restore NetworkManager configuration
echo -e "${YELLOW}Restoring NetworkManager configuration...${NC}"
sed -i 's/managed=true/managed=false/' /etc/NetworkManager/NetworkManager.conf
if check_error "Failed to restore NetworkManager configuration"; then
  report+="\e[32m[x] NetworkManager configuration: succeed\e[0m\n"
else
  report+="\e[31m[x] NetworkManager configuration: failed\e[0m\n"
fi
pause

# Remove dependencies
echo -e "${YELLOW}Removing dependencies...${NC}"
apt-get purge -y htop nmap apparmor bluez cifs-utils curl dbus jq libglib2.0-bin lsb-release network-manager nfs-common systemd-journal-remote systemd-resolved udisks2 wget
if check_error "Failed to remove dependencies"; then
  report+="\e[32m[x] Dependencies: succeed\e[0m\n"
else
  report+="\e[31m[x] Dependencies: failed\e[0m\n"
fi
apt-get autoremove -y
check_error "Failed to autoremove dependencies"
pause

# Final message
echo -e "${GREEN}Home Assistant Supervised and all related components have been uninstalled successfully!${NC}"

# Display report
echo -e "${YELLOW}Uninstallation Report:${NC}"
echo -e "${report}"

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
