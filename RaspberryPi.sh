# WARNING: PLEASE DO NOT USE THIS SCRIPT, JUST MANUALLY FOLLOW THE STEPS

# this script setup my personal ubuntu 18.04 dev-env for digital ocean host
cd ~

## Check system info: CPU, OS, OS bit
echo "CPU Information: `cat /proc/cpuinfo`"
echo "OS Information: `lsb_release  -a`"
echo "System is a `getconf LONG_BIT` bit system"
## Add Tsinghua source of apt
## TODO!

## install basic tools
sudo apt update
# sudo apt -y upgrade
sudo apt install -y build-essential vim zsh git tree cmake libboost-dev libssl-dev tmux vim git
# sudo apt install -y build-essential vim zsh git tree cmake libboost-dev libssl-dev tmux vim httpie youtube-dl pandoc git


## install python
# apt install -y python3-pip
# pip3 install virtualenv scipy numpy pandas jupyter tensorflow scikit-learn matplotlib seaborn pillow pyyaml requests

## Setup Git
./git_setup.sh

## install `oh-my-zsh`
cd ~/dotfiles
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

## Setup `oh-my-zsh`
cp rpi.zshrc ~/.zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
cp zsh/theme-powerlevel10k.zsh ~/.p10k.zsh
source ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
source ~/.zshrc

## Alternate Python version
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100 # Set python2 as default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150 # Set python3 as default
sudo update-alternatives --config python # Manually set default python

## install vim config
cp vim/rpi.vimrc ~/.vimrc
mkdir -p ~/.vim/colors/ && cp vim/colors/jellybeans.vim ~/.vim/colors/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
sudo apt-get install python3 python3-dev python3-setuptools
~/.vim/bundle/YouCompleteMe/install.py # --clang-completer --tern-completer # the last two are too slow, maybe later

## install tmux config
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
cp ~/.tmux/.tmux.conf.local ~/.
cp tmux/rpi.tmux.conf.local ~/.tmux.conf.local
tmux source-file ~/.tmux.conf

## fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

