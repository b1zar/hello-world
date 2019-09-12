echo Введите имя пользователя
read NAMEUSER
#Обновление всех пакетов
apt update && apt upgrade -y
#Установка окружения рабочего стола
sudo apt install xfce4 xfce4-goodies -y
#Создание нового юзера
adduser $NAMEUSER
#Установка патека по предоставлению root прав
apt install sudo
#Предоставление рут прав созданому юзеру
adduser $NAMEUSER sudo
#Установка репозитория NoMachine (Аналог RPD только для Linux)
cd /tmp && wget https://download.nomachine.com/download/6.7/Linux/nomachine_6.7.6_11_amd64.deb
#Установка NoMachine
dpkg -i nomachine_6.7.6_11_amd64.deb
#Установка репозитория для скачивания Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
#Установка Google Chrome
sudo apt-get update
sudo apt-get install google-chrome-stable -y
sudo apt update
sudo apt install build-essential -y
