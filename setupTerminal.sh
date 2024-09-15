#installing need software
sudo apt update
sudo apt install git -y
sudo apt install zsh -y
sudo apt install fzf -y
sudo apt install python3 -y
snap install docker

#change shell and make backup
chsh -s $(which zsh)
echo making backup of zshrc
mv ~/.zshrc ~/.zshrc.backup

#insatll JetBrainsMono font
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

#docker completions
mkdir -p ~/.docker/completions
docker completion zsh > ~/.docker/completions/_docker

#make ./zshrc file
cat <<EOF >> ~/.zshrc
# Set the directory we want to store zinit and plugins
ZINIT_HOME="\${XDG_DATA_HOME:-\${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "\$ZINIT_HOME" ]; then
   mkdir -p "\$(dirname \$ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "\$ZINIT_HOME"
fi

# Source/Load zinit
source "\${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::docker-compose
zinit snippet OMZP::dotnet
zinit snippet OMZP::golang
zinit snippet OMZP::npm
zinit snippet OMZP::nvm
zinit snippet OMZP::pip
zinit snippet OMZP::pm2
zinit snippet OMZP::rust
zinit snippet OMZP::ssh
zinit snippet OMZP::ubuntu
#zinit snippet OMZP::ufw
zinit snippet OMZP::yarn


# Load completions
fpath=(~/.docker/completions \$fpath)
autoload -Uz compinit
compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "\${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'

# Shell integrations
#eval "\$(fzf --zsh)"
EOF
