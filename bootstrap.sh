gcert
sudo glinux-add-repo -b docker-ce-"$(lsb_release -cs)"
sudo glinux-add-repo -b typescript stable
sudo apt update
sudo apt -y install build-essential zsh git wget python3 stow fzf htop xfsprogs pbzip2 sshuttle sshpass
sudo apt -y install kubectl intellij-ue-beta google-cloud-cli git-remote-google libvirt-daemon qemu-kvm virt-manager virt-viewer bridge-utils ansible aria2 qemu-utils google-guitar rapid-tool
git clone --recurse-submodules https://github.com/zizhengwu/dotfiles.git $HOME/git/dotfiles
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
rm $HOME/.zshrc $HOME/.hirc
bash $HOME/git/dotfiles/stow.sh
cat <<EOF | sudo tee /etc/sudoers.d/nopasswd
zizhengwu ALL=(ALL:ALL) NOPASSWD:ALL
EOF

# glinux homebrew
git clone https://github.com/Homebrew/brew $HOME/.linuxbrew/Homebrew
mkdir $HOME/.linuxbrew/bin
ln -s $HOME/.linuxbrew/Homebrew/bin/brew $HOME/.linuxbrew/bin
~/.linuxbrew/bin/brew install kind k9s neovim ripgrep kubectl zoxide

# Require interactions
sudo glinux-config -UX set timezone America/Los_Angeles
sudo glinux-config -UX set custom_etc_sudoers_d true
sudo glinux-config -UX set backups_exclude_dot_git no
/google/data/ro/teams/hi/install_hi.sh

# Old for abm and docker
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

git clone sso://gke-internal/syllogi/baremetal ~/git/baremetal
git clone sso://user/zizhengwu/baremetal-zizhengwu ~/Documents/baremetal-zizhengwu
gcloud auth login
gcloud config set project baremetal-zizhengwu
