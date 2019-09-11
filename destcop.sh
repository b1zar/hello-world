apt update && apt upgrade -y
sudo apt install xfce4 xfce4-goodies -y
adduser whoami
apt install sudo
adduser whoami sudo
cd /tmp && wget https://download.nomachine.com/download/6.7/Linux/nomachine_6.7.6_11_amd64.deb
dpkg -i nomachine_6.7.6_11_amd64.deb
