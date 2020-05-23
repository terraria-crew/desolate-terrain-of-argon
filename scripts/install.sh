#!/usr/bin/env bash

# Dependencies
sudo apt-get install -y screen

# Host Server Config
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd $script_dir
repo_root="$(git rev-parse --show-toplevel)"
popd
root_usr=root
root_grp=root
d_usr=terraria
version=1403
arch=x86_64

# Host Firewall (Disabled for now)
#sudo ufw allow ssh
#sudo ufw allow 7777/tcp
#sudo ufw enable
#sudo ufw delete 4 # Remove ipv6 rule

# Install Paths
server_fullname=terraria-$version-$arch-linux-gnu
server_exec_name=TerrariaServer.bin.$arch
install_archive=$repo_root/data/$server_fullname.tar.gz
install_base=/opt/terraria
install_dir=$install_base/$server_fullname
server_exec_path=$install_dir/$server_exec_name

# Installation
sudo mkdir -p $install_base/data/worlds
sudo mkdir -p $install_base/data/scripts
sudo tar zxvf $install_archive -C"$install_base"
sudo cp -ar "$repo_root/scripts/terraria.service" /etc/systemd/system/terraria.service
sudo cp -ar "$repo_root/scripts/terrariad" /usr/local/bin/terrariad
sudo cp -ar $repo_root/scripts/server_*.sh $install_base/scripts/
sudo chown -R $root_usr:$root_grp $install_base

# Terraria Config
if [ `id -u $d_usr 2>/dev/null` ]; then 
  echo "User '$d_usr' exists; create skipped.";
else
  echo "Creating user for server daemon: $d_usr";
  sudo useradd -r -m -d /srv/$d_usr $d_usr;
fi
