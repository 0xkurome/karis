#!/bin/bash
# Kurome's Auto Ricing Installation Script
# by Kurome
# License: GNU GPLv3

# checking that you have root
if [ $UID -ne 0 ]
then
    "Please use this script as root"
    exit
fi

# start out with the updates of all things
sudo apt update

# will need this for rust, later
sudo apt install -y build-essential

# need the gits
sudo apt install -y git

# install openvpn
sudo apt install -y openvpn

# install python3 & pip3
sudo apt install -y python3 python3-pip

# install kurcoder
git clone https://github.com/0xkurome/Kurcoder.git
pip3 install ipcalc
cd Kurcoder
sudo cp kurcoder.py kurcoder
sudo mv kurcoder /usr/local/bin
cd && rm -rf Kurcoder/

# install neofetch
sudo apt install -y neofetch

# install noto mono font for alacritty
sudo apt install -y fonts-noto-mono

# install brave browser
sudo apt install -y  apt-transport-https curl
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# install Visual Studio code
sudo apt install software-properties-common apt-transport-https
sudo wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
source ~/.profile
rustup override set stable
rustup update stable

# installing alacritty
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
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Make zsh the default shell
chsh -s $(which zsh)

# installing dotfiles & making them default
git clone https://github.com/0xkurome/dotfiles.git
cd dotfiles/
sudo cp zsh/.zshrc ~/.zshrc
sudo cp zsh/.zprofile ~/.zprofile
sudo cp bash/.bashrc ~/.bashrc
sudo cp .aliases ~/.aliases
sudo cp -r alacritty/.config/alacritty ~/.config
sudo cp vim/.vimrc ~/.vimrc
sudo cp neofetch/.config/neofetch/config.conf ~/.config/neofetch/
sudo cp radare2/.radare2rc ~/.radare2rc

