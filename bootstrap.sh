sudo apt update
sudo apt -y install build-essential zsh git wget python3 stow fzf htop xfsprogs pbzip2 sshuttle sshpass tldr

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install kind k9s neovim ripgrep kubectl zoxide eza bat fd ripgrep delta atuin chezmoi

git clone --recurse-submodules https://github.com/zizhengwu/dotfiles.git $HOME/git/dotfiles
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
rm $HOME/.zshrc $HOME/.hirc
chezmoi init https://github.com/zizhengwu/chezmoi_dotfiles.git
chezmoi apply

cat <<EOF | sudo tee /etc/sudoers.d/nopasswd
zizhengwu ALL=(ALL:ALL) NOPASSWD:ALL
EOF
