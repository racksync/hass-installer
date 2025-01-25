# 🏠 HASS INSTALLER

The `RACKSYNC HASS INSTALLER` script simplifies the installation of [Home Assistant Supervised](https://github.com/home-assistant/supervised-installer) on Debian. It automates a ton of commands to make the installation process easy and hassle-free. This script handles the installation of necessary dependencies, configuration of NetworkManager, and setup of Docker, OS Agent, and Home Assistant Supervised.

## 🚀 Benefits

- Automated installation of all necessary dependencies.
- Configuration of NetworkManager for better network management.
- Installation of Docker, OS Agent, and Home Assistant Supervised.
- Simplified process with prompts and error handling.

## 📋 How to Use

### ⚡ Quick Install

1. Run the following command to download and execute the installer script directly:
   ```bash
   curl -sSL https://raw.githubusercontent.com/racksync/hass-installer/main/installer.sh | bash
   ```

### 🛠️ Manual Install

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
   ./installer.sh
   ```

4. Follow the on-screen prompts to complete the installation.

5. After the installation is complete, you will be prompted to reboot your system. It is recommended to reboot for all changes to take effect.

## ⚠️ Note

This script is designed to work on Debian-based systems. Ensure you have a clean installation of Debian before running the script.


## 🛣️ Roadmap

📅 [Q2/2025] Easily install using a shortened URL with `curl` \
📅 [Q2/2025] Change the hostname to `homeassistant.local` \
📅 [Q2/2025] Fetch variants of configuration boilerplate files for Home Assistant. \
📅 [Q3/2025] Prune Unnecessary Docker Images & Logs with `crontab` \
📅 [Q3/2025] Theme & Custom Components Selection \
📅 [Q4/2025] Pre-Installed Addons

## 📄 LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Automation Training

- [สินค้าและบริการ](http://racksync.com)
- [เทรนนิ่งคอร์ส](https://facebook.com/racksync)

### Community

- [Home Automation Thailand](https://www.facebook.com/groups/hathailand)
- [Home Automation Marketplace](https://www.facebook.com/groups/hatmarketplace)
- [Home Automation Thailand Discord](https://discord.gg/Wc5CwnWkp4) 

## [RACKSYNC CO., LTD.](https://racksync.com)

บจก.แรคซิงค์ คือผู้เชี่ยวชาญด้าน Automation และ Smart Solutions ทุกขนาด เรามีบริการให้คำปรึกษาตลอดจนวางระบบ ติดตั้งและมอนิเตอร์โดยผู้เชี่ยวชาญ นอกจากนี้เรายังเป็นบริษัทรับพัฒนา Software As A Service แบบครบวงจรอีกด้วย
\
\
RACKSYNC COMPANY LIMITED \
Suratthani, Thailand 84000 \
Email : devops@racksync.com \
Tel : +66 85 880 8885 

[![Home Automation Thailand Discord](https://img.shields.io/discord/986181205504438345?style=for-the-badge)](https://discord.gg/Wc5CwnWkp4) [![Github](https://img.shields.io/github/followers/racksync?style=for-the-badge)](https://github.com/racksync) 
[![WebsiteStatus](https://img.shields.io/website?down_color=grey&down_message=Offline&style=for-the-badge&up_color=green&up_message=Online&url=https%3A%2F%2Fracksync.com)](https://racksync.com)



