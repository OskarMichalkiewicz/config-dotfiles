eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/starship.toml

alias vim=nvim
source ~/.zsh_profile

PATH=~/.console-ninja/.bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
