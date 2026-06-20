export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# nvim configuration
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="$PATH:/Users/efleming/.local/bin"

export PATH="$PATH:/Users/efleming/.deno/bin"

export PATH="$PATH:/opt/homebrew/opt/openjdk@21/bin"

export PATH="$PATH:/Users/efleming/.cargo/bin"

export PATH="$PATH:/Users/efleming/go/bin"

export PATH="$PATH:/Users/efleming/.local/bin/claude"
