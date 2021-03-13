# WARNING: PLEASE DO NOT USE THIS SCRIPT, JUST MANUALLY FOLLOW THE STEPS
# this script setup my personal ubuntu 20.04 dev-env for digital ocean host

# Stage 1: Direct interact with physical machine
## Install ssh server and git
sudo apt install openssh-server git
## Clone this repo
git clone https://github.com/liborui/dotfiles.git
## Setup non-passwd login of SSH
ssh-copy-id -i ~/.ssh/id_rsa.pub <remote_user>@<remote_ip> -p <remote_port>


# Stage 2: Remote control with SSH
cd ~/dotfiles

## Check system info: CPU, OS, OS bit
echo "CPU Information: `cat /proc/cpuinfo`"
echo "OS Information: `lsb_release  -a`"
echo "System is a `getconf LONG_BIT` bit system"
## Add USTC/Tsinghua source of apt (focal for 20.04LTS)
sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
sudo cp sources.list.ustc /etc/apt/sources.list

## set ssh login without password (on your PC)
ssh-copy-id -i ~/.ssh/id_rsa.pub <username>@<ip> -p <port>

## install basic tools
sudo apt update
# sudo apt -y upgrade
sudo apt install -y vim zsh tree tmux net-tools
sudo apt install -y build-essential cmake libboost-dev libssl-dev # python3 python3-dev
# sudo apt install -y build-essential vim zsh git tree cmake libboost-dev libssl-dev tmux vim httpie youtube-dl pandoc git


## install python
# apt install -y python3-pip
# pip3 install virtualenv scipy numpy pandas jupyter tensorflow scikit-learn matplotlib seaborn pillow pyyaml requests

## Setup Git
./git_setup.sh

## install `oh-my-zsh`
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Setup `oh-my-zsh`
cp zsh/linux.zshrc ~/.zshrc
### If use 'powerlevel10k' as the theme, if dont have font, then use theme 'ys'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
cp zsh/rpi.p10k.zsh ~/.p10k.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
source ~/.zshrc

## [OPTIONAL] Alternate Python version
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100 # Set python2 as default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150 # Set python3 as default
sudo update-alternatives --config python # Manually set default python

## install vim config
### Base VIM Config
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh
### Pro VIM Config with plugins
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

## [OPTIONAL] Install Anaconda
### Find latest anaconda in TUNA with wget
https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/
chmod a+x Anaconda-x
./Anaconda-x        # Do not use sudo!

## [Optional] Install NVIDIA GPU Docker
### First, use the Software & Update of Ubuntu to install the driver.
Software & Update
### Install Docker and set to 
sudo apt install docker.io
### [Optional] Update NVIDIA docker source and install it
### Ref: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
### Set Docker source
sudo cp docker.daemon.json /etc/docker/daemon.json
sudo systemctl restart docker
### Usage:
docker pull pytorch/pytorch
sudo docker run --rm --gpus all pytorch/pytorch nvidia-smi # Then there should be NVIDIA-SMI output
docker pull ufoym/deepo
sudo docker run --rm --gpus all ufoym/deepo nvidia-smi

## [OPTIONAL] Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
## [OPTIONAL] Add Tsinghua source for CARGO
cat << EOF > $HOME/.cargo/config
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
EOF

## [OPTIONAL] Fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

## [OPTIONAL] use advanced cp and mv to show status line when copying
wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz
tar xvJf coreutils-8.32.tar.xz
cd coreutils-8.32/
wget https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-8.32.patch
patch -p1 -i advcpmv-0.8-8.32.patch
./configure
make
### alias
sudo mv ./src/cp /usr/local/bin/advcp
sudo mv ./src/mv /usr/local/bin/advmv
echo alias cp '/usr/local/bin/advcp -g' >> ~/.zshrc
echo alias mv '/usr/local/bin/advmv -g' >> ~/.zshrc
