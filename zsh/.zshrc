eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/starship.toml

alias vim=nvim
alias pip=pip3
alias python=python3
source ~/.zsh_profile

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/aldona/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "`fnm env --use-on-cd --shell zsh`"
fi
