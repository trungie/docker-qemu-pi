To get raspbian arm emulated on macosx intel

# Challenges

Need - test ansible playbooks on raspberry pi raspian os without hardware

- Want to run headless raspian no UI
- Qemu provides a way to run emulated arm raspbian on macosx x86. 
- Rpi since 2022 doesn't provide default login
- Qemu setup takes some effort
- Docker image lukechilds/dockerpi hides away most of the qemu
- Just need to setup a user so can login after

# Howto

1. docker pull lukechilds/dockerpi:vm
2. download raspberry pi os lite image https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-32-bit 
3. use vagrant to mount image and write userconf file to setup a login user - vagrant up, run `sudo ./firstboot.sh .....img`
4. docker run -it --mount type=bind,source="$(pwd)"/2023-02-21-raspios-bullseye-armhf-lite.img,target=/sdcard/filesystem.img -p 5022:5022 lukechilds/dockerpi:vm

# Handy

- sudo dpkg-reconfigure openssh-server 
- sudo systemctl start ssh.service
- ssh -p 5022 berryboot@localhost

# References

- https://www.raspberrypi.com/news/raspberry-pi-bullseye-update-april-2022/
- https://github.com/lukechilds/dockerpi
