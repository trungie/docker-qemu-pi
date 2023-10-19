# Raspberry Pi Raspbian ARM Emulation on macOS (Intel)

This repository provides a guide and related scripts for emulating a Raspberry Pi running Raspbian OS on an Intel-based macOS system. This setup is ideal for testing Ansible playbooks for Raspberry Pi without the need for actual hardware.

## 📋 Table of Contents
1. [Challenges](#challenges)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Handy Commands](#handy-commands)
6. [References](#references)

## 🤔 Challenges

- Running headless Raspbian (No UI)
- Raspbian does not provide a default login since 2022
- QEMU setup can be complicated
- Docker image by Luke Childs simplifies the QEMU setup but requires user configuration

## 🛠 Prerequisites

- Docker
- Vagrant
- xz (decompression utility)

## 📦 Installation

1. **Pull the Docker Image**

    ```bash
    docker pull lukechilds/dockerpi:vm
    ```
  
2. **Download Raspberry Pi OS Lite Image**

    Download the image from [Raspberry Pi OS](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-32-bit).

3. **Decompress the Image**

    ```bash
    xz -d 2023-02-21-raspios-bullseye-armhf-lite.img.xz
    ```

4. **Configure User Settings with Vagrant**

    Use Vagrant to mount the image and set up a login user.

    ```bash
    vagrant up
    sudo ./firstboot.sh .....img
    ```

## 🚀 Usage

1. **Run the Emulated Raspbian**

    ```bash
    docker run -it --mount type=bind,source="$(pwd)"/2023-02-21-raspios-bullseye-armhf-lite.img,target=/sdcard/filesystem.img -p 5022:5022 lukechilds/dockerpi:vm
    ```

## 📚 Handy Commands

- **Reconfigure SSH**

    ```bash
    sudo dpkg-reconfigure openssh-server
    ```

- **Start SSH Service**

    ```bash
    sudo systemctl start ssh.service
    ```

- **SSH into Emulated Pi**

    ```bash
    ssh -p 5022 berryboot@localhost
    ```

## 📚 References

- [Raspberry Pi Bullseye Update](https://www.raspberrypi.com/news/raspberry-pi-bullseye-update-april-2022/)
- [DockerPi by Luke Childs](https://github.com/lukechilds/dockerpi)
