#!/bin/bash

# Function to install Homebrew on macOS
install_brew_mac() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Function to install required packages on macOS
install_packages_mac() {
    brew install git neovim ripgrep alacritty tmux bat fzf
    brew tap homebrew/cask-fonts && brew install --cask font-fira-code-nerd-font
    brew install bun
    npm install --global yarn
}

install_zsh_mac() {
  brew install zsh
}

install_zsh_ubuntu() {
  sudo apt install -y zsh
}

install_git_ubuntu() {
  sudo apt install -y git-all
}

install install_neovim_ubuntu() {
  sudo apt-get install software-properties-common
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt-get update
  sudo apt-get install neovim
}

# Function to install required packages on Ubuntu
install_packages_ubuntu() {
    sudo apt update
    sudo apt install -y git-all ripgrep tmux bat fzf
    sudo apt install -y fonts-firacode
    npm install --global yarn
}

# Function to set up zsh and oh-my-zsh
setup_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://gist.github.com/39eaf2933273a41fd72c971ffb76cfe1.git ~/.zshrc_temp
    cp ~/.zshrc_temp/.zshrc ~/.zshrc
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm' >> ~/.zshrc
        echo '[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> ~/.zshrc
        chsh -s $(which zsh)  # Set zsh as default shell on macOS
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.zshrc
        echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.zshrc
        sudo chsh -s $(which zsh) "$USER"  # Set zsh as default shell on Linux
    fi
    rm -rf ~/.zshrc_temp
}

# Function to set up neovim, tmux, and alacritty configs
setup_configs() {
    git clone https://github.com/ParthJadhav/AstroNvim.git ~/.config/nvim
    git clone https://gist.github.com/610ed3e4031ea163976b7cc9f9579726.git ~/.tmux_conf_temp
    cp ~/.tmux_conf_temp/.tmux.conf ~/.tmux.conf
    rm -rf ~/.tmux_conf_temp
    git clone https://gist.github.com/7809b55509a828ff9a760240574d2a76.git ~/.config/alacritty
}

# Function to install Rust via rustup
install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

# Function to install additional tools
install_additional_tools() {
    cargo install exa
}

# Check OS and execute appropriate functions
case "$(uname -s)" in
    Darwin*)
        install_brew_mac
        install_zsh_mac
        setup_zsh
        install_packages_mac
        setup_configs
        install_rust
        install_additional_tools
        ;;
    Linux*)
        install_zsh_ubuntu
        install_git_ubuntu
        setup_zsh
        install_packages_ubuntu
        install_neovim_ubuntu
        setup_configs
        install_rust
        install_additional_tools
        ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac

echo "Development environment setup completed."
