#! /usr/bin/env bash
set -eu -o pipefail

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
	ripgrep
	curl
	wget
	jq
EOF
)

echo "Installing Neovim"
rm -rf "$HOME/neovim"
git clone https://github.com/neovim/neovim.git "$HOME/neovim"

cd "$HOME/neovim"
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd "$HOME"

rm -rf "$HOME/.config"
mkdir "$HOME/.config"
cp -r "$HOME/Profile/.config/" "$HOME"

sudo apt update
sudo apt upgrade
