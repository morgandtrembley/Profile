#! /usr/bin/env bash
set -eu -o pipefail

echo "$HOME"

echo "Updating..."
sudo apt update
sudo apt upgrade

echo "Update finished. Installing Pre-reqs"
while read -r p ; do sudo apt install -y $p ; done < <( cat << "EOF"
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

rm -rf neovim
echo "Installing Neovim"
git clone https://github.com/neovim/neovim.git

cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd ..

echo "$HOME"
mv neovim "$HOME/neovim"

sudo apt update
sudo apt upgrade
