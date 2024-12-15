#! /usr/bin/env bash
set -eu -o pipefail

echo "Updating..."
sudo apt update
sudo apt upgrade

echo "Update finished. Installing Pre-reqs"
while read -r p ; do sudo apt install -y $p ; done < <( cat << "EOF"
	git
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
	fzf
	fd-find
	tmux
	tldr
	thefuck
	sd
	neofetch
	figlet
	lolcat
	cargo
	rustup
EOF
)

git config --global user.name "mtrembley"
git config --global user.email "morgandtrembley@gmail.com"

ssh-keygen -f "$HOME/.ssh/id_rsa" -P ""

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

cargo install rm-improved
cargo install tre-command

echo "Installing Neovim"
rm -rf "$HOME/neovim"
git clone https://github.com/neovim/neovim.git "$HOME/neovim"

cd "$HOME/neovim"
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd "$HOME"

#rm -rf "$HOME/.config"
#mkdir "$HOME/.config"
#cp -r "$HOME/Profile/.config/" "$HOME"

wget https://dl.google.com/go/go1.22.2.linux-amd64.tar.gz
sudo tar -xvf go1.22.2.linux-amd64.tar.gz
sudo mv go /usr/local

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#rm -rf "$HOME/.bashrc"
#cp "$HOME/Profile/.bashrc" "$HOME"

#rm -rf "$HOME/.zshrc"
#cp "$HOME/Profile/.zshrc" "$HOME"

#rm -rf "$HOME/.gitconfig"
#cp "$HOME/Profile/.gitconfig" "$HOME"

sudo apt update
sudo apt upgrade
