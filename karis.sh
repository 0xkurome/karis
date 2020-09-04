#!/bin/bash
# Kurome's Auto Ricing Installation Script
# by Kurome
# License: GNU GPLv3

# Define colors
RED=`tput bold && tput setaf 1`
CYAN=`tput bold && tput setaf 6`
NC=`tput sgr0`

function RED(){
    echo -e "\n${RED}${1}${NC}"
}
function CYAN(){
    echo -e "\n${CYAN}${1}${NC}"
}

# go to home dir
cd

# start out with the updates of all things
CYAN "Updating System"
sudo apt update

# will need this for rust, later
CYAN "Installing build-essentials for rust"
sudo apt install -y build-essential

# need the gits
CYAN "Installing git"
sudo apt install -y git

# install openvpn
CYAN "Installing openVPN"
sudo apt install -y openvpn

# install python3 & pip3
CYAN "Installing python3 & PIP"
sudo apt install -y python3 python3-pip

# install kurcoder
CYAN "Installing Kurcoder & adding to /usr/local/bin"
git clone https://github.com/0xkurome/Kurcoder.git
pip3 install ipcalc
cd Kurcoder
sudo cp kurcoder.py kurcoder
sudo mv kurcoder /usr/local/bin
cd .. && rm -rf Kurcoder/

# install neofetch
CYAN "Installing Neofetch"
sudo apt install -y neofetch

# install RE suite
CYAN "Installing ltrace, strace, and gdb"
sudo apt install -y ltrace strace gdb

# install openjdk-11 for ghidra
CYAN "Installing OpenJDK-11 for Ghidra"
sudo apt install -y openjdk-11-jdk openjdk-11-jre-headless

# install Ghidra
CYAN "Installing Ghidra & moving dir to /opt"
mkdir ghidra && cd ghidra
wget https://ghidra-sre.org/ghidra_9.1.2_PUBLIC_20200212.zip
unzip ghidra_9.1.2_PUBLIC*
rm *.zip && cd ..
sudo mv ghidra/ /opt

# install noto mono font for alacritty
CYAN "Installing Noto Mono for Alacirtty"
sudo apt install -y fonts-noto-mono

# install brave browser
CYAN "Installing Brave Browser"
sudo apt install -y  apt-transport-https curl
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# install Visual Studio code
CYAN "Installing Visual Studio Code"
sudo apt install -y software-properties-common apt-transport-https
sudo wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code &&

# install rust
CYAN "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
source ~/.profile
rustup override set stable
rustup update stable

# installing alacritty
CYAN "Installing Alacritty"
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release
sudo mv target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
cd && sudo rm -rf alacirtty/



# install zsh
RED "Installing zsh - *DONT FORGET TO TYPE exit AFTER zsh INSTALL*"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&

# installing dotfiles & making them default
CYAN "Installing & updating local dotfiles"
git clone https://github.com/0xkurome/dotfiles.git
cd dotfiles/ 
sudo cp zsh/.zshrc ~/.zshrc
sudo cp zsh/.zprofile ~/.zprofile
sudo cp .oh-my-zsh/themes/kurome.zsh-theme ~/.oh-my-zsh/themes
sudo cp bash/.bashrc ~/.bashrc
sudo cp .aliases ~/.aliases
sudo cp -r alacritty/.config/alacritty ~/.config
sudo cp vim/.vimrc ~/.vimrc
sudo cp -r neofetch/.config/neofetch/ ~/.config
sudo cp radare2/.radare2rc ~/.radare2rc
cd

# remove extra dotfiles
CYAN "removed pre-oh-my-zshrc"
rm -rf .zshrc.pre-oh-my-zsh

# Make zsh the default shell
CYAN "making zsh the default shell"
chsh -s $(which zsh) && exit
