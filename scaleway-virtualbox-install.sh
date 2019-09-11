alias wget='wget -q --no-check-certificate'

# so that we can install virtualbox via apt-get
for x in xenial xenial-security xenial-updates; do
  egrep -qe "deb-src.* $x " /etc/apt/sources.list || echo "deb-src http://archive.ubuntu.com/ubuntu ${x} main universe" | tee -a /etc/apt/sources.list
done
echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" | tee -a /etc/apt/sources.list.d/virtualbox.list
wget https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -

apt-get update
apt-get install -y unzip htop curl wget tree nano build-essential libssl-dev

# allow us to make a kernel
arch="$(uname -m)"
release="$(uname -r)"
upstream="${release%%-*}"
local="${release#*-}"
echo $release
echo $local
echo $upstream
mkdir -p /usr/src
wget -O "/usr/src/linux-${upstream}.tar.xz" "https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-${upstream}.tar.xz"
tar xf "/usr/src/linux-${upstream}.tar.xz" -C /usr/src/
ln -fns "/usr/src/linux-${upstream}" /usr/src/linux
ln -fns "/usr/src/linux-${upstream}" "/lib/modules/${release}/build"
zcat /proc/config.gz > /usr/src/linux/.config
printf 'CONFIG_LOCALVERSION="%s"\nCONFIG_CROSS_COMPILE=""\n' "${local:+-$local}" >> /usr/src/linux/.config
wget -O /usr/src/linux/Module.symvers "http://mirror.scaleway.com/kernel/${arch}/${release}/Module.symvers"

# make kernel (no idea why? but anyway)
export NUM_CORES=$(cat /proc/cpuinfo | grep vendor_id | wc -l)
make -j${NUM_CORES} -C /usr/src/linux prepare modules_prepare
export KERN_DIR=/lib/modules/$(uname -r)/build

# install virtualbox (which also does some kernel stuff)
apt-get install -y dkms virtualbox-5.2

sudo -E /sbin/rcvboxdrv setup

VBoxManage --version

wget https://download.virtualbox.org/virtualbox/5.2.12/Oracle_VM_VirtualBox_Extension_Pack-5.2.12.vbox-extpack
yes | VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.12.vbox-extpack
