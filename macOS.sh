# 其他系统优化
## Finder: 显示路径栏
defaults write com.apple.Dock autohide-delay -float 0 && killall Dock
## Alfred workflow在Alfred/文件夹下

# 安装iterm2，略
# 安装brew
xcode-select --install # 首先安装xcode-clt
## 安装homebrew（从tuna或原生）
### macOS 用户，请使用以下两句命令
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
### 从本镜像下载安装脚本，修改其中的仓库源并安装 Homebrew / Linuxbrew
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
/bin/bash -c "$(sed 's|^HOMEBREW_BREW_GIT_REMOTE=.*$|HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"|g' brew-install/install.sh)"
rm -rf brew-install
### 也可从 GitHub 获取官方安装脚本，修改其中的仓库源，运行以安装 Homebrew / Linuxbrew
/bin/bash -c "$(
    curl -fsSL https://github.com/Homebrew/install/raw/master/install.sh |
    sed 's|^HOMEBREW_BREW_GIT_REMOTE=.*$|HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"|g'
)"
## 替换brew上游
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git


# 安装 ZSH and oh-my-zsh, 
#ref: https://www.jianshu.com/p/246b844f4449
brew install zsh zsh-completions
## 切换到zsh
sudo chsh -s $(which zsh)
## 如果显示 "chsh:no changes made", then:
dscl . -read /Users/$USER/ UserShell
exec su - $USER
## 重启iterm2，安装oh-my-zsh，如果不成功，export一下http_proxy, https_proxy
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
## 换成Powerline字体
## 字体在本仓库font文件夹下

# 如果发现有备份拷贝过来的文件夹权限有问题的话，使用这个命令修改至正常权限
chmod -R 755 *
# 换到Linux.sh继续设置
