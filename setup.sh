#!/bin/bash

# Function to ask for password and use it throughout the script
ask_password() {
    echo "Please enter your password:"
    read -s PASSWORD
    export PASSWORD
}

# Function to install Homebrew on macOS
install_brew_mac() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Function to install required packages on macOS
install_packages_mac() {
    brew install git zsh neovim ripgrep alacritty tmux bat fzf
    brew tap homebrew/cask-fonts && brew install --cask font-fira-code-nerd-font
    brew install bun
    npm install --global yarn
}

# Function to install required packages on Ubuntu
install_packages_ubuntu() {
    sudo apt update
    sudo apt install -y git-all zsh neovim ripgrep tmux bat fzf
    sudo apt install -y fonts-firacode
    npm install --global yarn
}

# Function to set up zsh and oh-my-zsh
setup_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://gist.github.com/39eaf2933273a41fd72c971ffb76cfe1.git ~/.zshrc_temp
    cp ~/.zshrc_temp/.zshrc ~/.zshrc
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

# Function to install Node.js via nvm
install_node() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    nvm install --lts
    nvm use --lts
}

# Function to install additional tools
install_additional_tools() {
    cargo install exa
}

# Check OS and execute appropriate functions
case "$(uname -s)" in
    Darwin*)
        ask_password
        install_brew_mac
        install_packages_mac
        setup_zsh
        setup_configs
        install_rust
        install_node
        install_additional_tools
        ;;
    Linux*)
        ask_password
        install_packages_ubuntu
        setup_zsh
        setup_configs
        install_rust
        install_node
        install_additional_tools
        ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac

echo "Development environment setup completed."
