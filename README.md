# 🏠 HASS INSTALLER

The `RACKSYNC HASS INSTALLER` script simplifies the installation of [Home Assistant Supervised](https://github.com/home-assistant/supervised-installer) on Debian. It automates a ton of commands to make the installation process easy and hassle-free. This script handles the installation of necessary dependencies, configuration of NetworkManager, and setup of Docker, OS Agent, and Home Assistant Supervised.

## 🚀 Benefits

- Automated installation of all necessary dependencies.
- Configuration of NetworkManager for better network management.
- Installation of Docker, OS Agent, and Home Assistant Supervised.
- Simplified process with prompts and error handling.

## 📋 How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/racksync/hass-installer.git
   cd hass-installer
   ```

2. Make the installer script executable:
   ```bash
   chmod +x installer.sh
   ```

3. Run the installer script:
   ```bash
   sudo ./installer.sh
   ```

4. Follow the on-screen prompts to complete the installation.

5. After the installation is complete, you will be prompted to reboot your system. It is recommended to reboot for all changes to take effect.

## ⚠️ Note

This script is designed to work on Debian-based systems. Ensure you have a clean installation of Debian before running the script.

## 📄 LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
