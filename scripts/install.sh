#!/usr/bin/env bash

# Dependencies
sudo apt-get install -y screen

# Host Server Config
SCRIPT_DIR="$(cd "$(dirname "${bash_source[0]}")" && pwd)"
pushd $SCRIPT_DIR
REPO_ROOT="$(git rev-parse --show-toplevel)"
popd
root_usr=root
root_grp=root
d_usr=terraria
version=1403
arch=x86_64

# Host Firewall
sudo ufw allow ssh
sudo ufw allow 7777/tcp
sudo ufw enable
sudo ufw delete 4 # Remove ipv6 rule

# Install Paths
server_fullname=terraria-$version-$arch-linux-gnu
server_exec_name=TerrariaServer.bin.$arch
tarfile=$REPO_ROOT/data/$server_fullname.tar.gz
install_base=/opt/terraria
install_dir=$install_base/$server_fullname
server_exec_path=$install_dir/$server_exec_name

# Installation
sudo mkdir -p $install_base
sudo tar zxvf $tarfile -C"$install_base"
sudo chown -R $root_usr:$root_grp $install_base
sudo chmod +x $server_exec_path
sudo cp -ar "$REPO_ROOT/scripts/terraria.service" /etc/systemd/system/terraria.service
sudo cp -ar "$REPO_ROOT/scripts/terrariad" /usr/local/bin/terrariad

# Terraria Config
sudo useradd -r -m -d /srv/$d_usr $d_usr
sudo mkdir -p /opt/terraria/data/worlds
sudo mkdir -p /opt/terraria/data/scripts
