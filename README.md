## Kyli0x's Auto Ricing Installation Script for kali linux 2020.3+

### Install
<b>Do not</b> run `karis` with sudo

Use the Python module, Karis, to install easily:

```
pip3 install karis
karis
```

or clone manually

```
$ git clone https://github.com/kyli0x/karis.git
$ cd karis
$ chmod +x karis.sh
$ ./karis.sh
```

Rust will ask if you would want default or customized installtion (I suggest choosing the default option `1` if you never worked with rust before)
<br>
When prompted to make oh-my-zsh default type: `y`
<br>
Once you are at the oh-my-zsh prompt type: `exit` to finish the installation
<br>
After the script is finished please log out and log back in to update the default shell

### Tools Included or updated
- Alacritty
- Exiftool
- Filezilla
- Kurcoder (placed in /usr/local/bin to use globally by just running `$ kurcoder`
- Neofetch
- OpenVPN
- Python3 & pip3
- Ranger
- Remmina
- Rust
- RustScan
- StegCracker
- Visual Studio Code
- zsh (with oh-my-zsh)

### Reverse Engineering & Malware Analysis Tools
- edb-debugger
- gdb
- Ghidra (placed in /opt)
- ollydbg
- ltrace
- strace

### Dotfiles added or changed
- alacritty.yml
- .aliases
- .bashrc
- neofetch .config
- .oh-my-zsh/themes (kurome style theme based on mh theme)
- Removed: .zshrc.pre-oh-my-zsh
- .radare2rc
- .vimrc
- .zprofile
- .zshrc
