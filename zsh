export ZSH="$HOME/.oh-my-zsh"
export PATH=/home/parth/.local/bin:$PATH
PATH=~/spotify:$PATH


ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias e="nvim ."
alias c="clear"

alias cat="bat"
alias ls="exa"

alias yarn="bun"
alias pnpm="bun"
alias npm="bun"
alias npx="bunx"
alias ni="bun install"

alias q="exit"
alias ta="tmux attach -t"
alias tn="tmux new -s"
alias tmls="tmux ls"

export LC_ALL=en_US.UTF-8
export LANG=en_us.UTF-8
source ~/.cargo/env

export PATH=/Users/parthjadhav/.local/bin:$PATH
export PATH=$PATH:/Users/parthjadhav/.npm-global/bin

# pnpm
export PNPM_HOME="/Users/parthjadhav/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/parthjadhav/.bun/_bun" ] && source "/Users/parthjadhav/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
