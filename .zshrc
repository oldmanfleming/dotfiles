export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/.cargo/bin"

export PATH="$PATH:/usr/local/go/bin"

export PATH="$PATH:$HOME/.deno/bin"

export PATH="$PATH:$HOME/.fly/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
