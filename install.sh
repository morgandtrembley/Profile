#! /usr/bin/env bash
set -eu -o pipefail

sudo -n true
test $? -eq 0 || exit 1 "Run: sudo bash install.sh"

echo "Updating..."
apt update
apt upgrade

echo "Update finished. Installing Pre-reqs"
while read -r p ; do apt install ; done < <( cat << "EOF"
	zip
	unzip
	make
	cmake
	gettext
	curl
	wget
	jq
EOF
)

echo "Installing Neovim"
git clone https://github.com/neovim/neovim.git

cd neovim
git checkout stable
make CMAKE_BUILD_TYPE-RelWithDebInfo
make install

apt update
apt upgrade
