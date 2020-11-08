#!/bin/bash
# Kyli0x's Auto Ricing Installation Script
# by Kyli0x
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

# need the gits
CYAN "Installing git"
sudo apt install -y git

# will need this for rust, later
CYAN "Installing build-essentials for rust"
sudo apt install -y build-essential

# install noto mono font for alacritty
CYAN "Installing Noto Mono for Alacirtty"
sudo apt install -y fonts-noto-mono

# install rust
CYAN "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
source ~/.profile
rustup override set stable
rustup update stable

# install alacritty
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
cd && sudo rm -rf alacritty/

# install tmux
CYAN "Installing tmux"
sudo apt install -y tmux

# install neofetch
CYAN "Installing Neofetch"
sudo apt install -y neofetch

# install ranger
CYAN "Installing Ranger"
sudo apt install -y ranger

# install breeze cursor theme
CYAN "Installing Breeze Cursor Theme"
sudo apt install -y breeze-cursor-theme

# install papirus icon theme
CYAN "Installing Papirus-Dark Icon Theme"
sudo apt install -y papirus-icon-theme

# install openvpn
CYAN "Installing openVPN"
sudo apt install -y openvpn

# install rustscan
CYAN "Installing RustScan - THANKS BEE FOR THIS AMAZING TOOL!!"
wget https://github.com/RustScan/RustScan/releases/download/1.8.0/rustscan_1.8.0_amd64.deb
sudo dpkg -i rustscan*
sudo rm rustscan*.deb

# install python3 & pip3
CYAN "Installing python3 & PIP"
sudo apt install -y python3 python3-pip

# install kurcoder
CYAN "Installing Kurcoder & adding to /usr/local/bin"
git clone https://github.com/kyli0x/Kurcoder.git
pip3 install ipcalc
cd Kurcoder
sudo cp kurcoder.py kurcoder
sudo mv kurcoder /usr/local/bin
cd .. && rm -rf Kurcoder/

# install Filezilla
CYAN "Installing Filezilla"
sudo apt install -y filezilla filezilla-common

# install Remmina for RDP
CYAN "Installing Remmina"
sudo apt install -y remmina

# install exiftool
CYAN "Installing Exiftool"
sudo apt install -y exiftool

# install stegcracker
CYAN "Installing Stegcracker"
sudo apt install -y steghide
pip3 install stegcracker

# install RE suite
CYAN "Installing my personal Kurome's RE Suite including ltrace, strace, gdb, ollydgb, & edb"
sudo apt install -y ltrace strace gdb ollydbg edb-debugger

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
sudo apt install code

# install zsh
RED "Installing zsh - *DONT FORGET TO TYPE exit AFTER SEEING THE zsh PROMPT TO FINISH THE INSTALL*"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# installing dotfiles & making them default
CYAN "Installing & updating my personal dotfiles"
git clone https://github.com/kyli0x/kyricer.git
cd kyricer/ 
chmod +x install.sh
./install.sh

# remove extra dotfiles
CYAN "removed pre-oh-my-zshrc"
rm -rf .zshrc.pre-oh-my-zsh

# Make zsh the default shell
CYAN "making zsh the default shell"
chsh -s /bin/zsh 

CYAN "Please log out and log back in to update default shell"
exit
