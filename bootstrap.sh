gcert
sudo glinux-add-repo -b docker-ce-"$(lsb_release -cs)"
sudo glinux-add-repo -b typescript stable
sudo apt update
sudo apt -y install kubectl
sudo apt install -y git
sudo apt install -y intellij-ue-beta
sudo apt install -y wget
sudo apt install -y python3
sudo apt install -y stow
sudo apt install -y fzf
sudo apt install -y google-cloud-sdk
sudo apt install -y code visual-studio-code-google3
sudo apt install -y git-remote-google
sudo apt install -y google-cloud-sdk-anthos-auth
git clone --recurse-submodules https://github.com/zizhengwu/dotfiles.git $HOME/git/dotfiles
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
yes n | sh install.sh
rm install.sh
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
rm $HOME/.zshrc
ln -s $HOME/git/dotfiles/ubuntu/.zshrc_google_glinux $HOME/.zshrc_google_glinux 
ln -s $HOME/git/dotfiles/ubuntu/.zshrc_google_shared $HOME/.zshrc_google_shared
ln -s $HOME/git/dotfiles/ubuntu/.zshrc $HOME/.zshrc
ln -s $HOME/git/dotfiles/ubuntu/.p10k.zsh $HOME/.p10k.zsh
ln -s ~/git/dotfiles/ubuntu/.hirc $HOME/.hirc
bash ~/git/dotfiles/stow.sh
git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
mkdir ~/.linuxbrew/bin
ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
sudo apt -y install docker-ce || true
sudo service docker stop
sudo ip link set docker0 down
sudo ip link del docker0
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "data-root": "/usr/local/google/docker",
  "bip": "192.168.9.1/24",
  "default-address-pools": [
    {
      "base": "192.168.11.0/22",
      "size": 24
    }
  ],
  "storage-driver": "overlay2",
  "registry-mirrors": ["https://mirror.gcr.io"]
}
EOF
sudo service docker start
sudo addgroup docker || true
sudo adduser $USER docker
~/.linuxbrew/bin/brew install kind k9s
/google/data/ro/teams/hi/install_hi.sh
cat <<EOF | sudo tee /etc/sudoers.d/nopasswd
zizhengwu ALL=(ALL:ALL) NOPASSWD:ALL
EOF
sudo glinux-config set custom_etc_sudoers_d true
git clone sso://gke-internal/syllogi/baremetal ~/git/baremetal
git clone sso://user/zizhengwu/baremetal-zizhengwu ~/Documents/baremetal-zizhengwu
gcloud auth login
gcloud config set project baremetal-zizhengwu
