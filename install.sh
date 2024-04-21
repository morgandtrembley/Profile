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
    zsh
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

wget https://dl.google.com/go/go1.22.2.linux-amd64.tar.gz
sudo tar -xvf go1.22.2.linux-amd64.tar.gz
sudo mv go /usr/local




rm -rf "$HOME/.bashrc"
cp "$HOME/Profile/.bashrc" "$HOME"

sudo apt update
sudo apt upgrade
