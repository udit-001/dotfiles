#Source terminal fonts
source ~/.fonts/*.sh

# Enable autocompletions
#autoload -Uz compinit
#typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
#if [ $(date +'%j') != $updated_at ]; then
#  compinit -i
#else
#  compinit -C -i
#fi
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

zmodload -i zsh/complist

# Scripts to be played after inactivity
TMOUT=300
TRAPALRM(){
  tput smcup
  cmatrix -s -a
  tput rmcup
}

# Aliases
# alias ls='lsd -F --group-dirs first' # Not being used 
source $HOME/.zsh_aliases

# Save history so we get auto suggestions
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
# Options
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances
setopt correct_all # autocorrect commands
setopt interactive_comments # allow comments in interactive shells
# Improve autocompletion style
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
# Load antibody plugin manager
source <(antibody init)
# Plugins
antibody bundle zdharma/fast-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-history-substring-search
antibody bundle zsh-users/zsh-completions
antibody bundle marzocchi/zsh-notify
antibody bundle buonomo/yarn-completion
antibody bundle robbyrussell/oh-my-zsh path:plugins/command-not-found
antibody bundle robbyrussell/oh-my-zsh path:plugins/colored-man-pages
antibody bundle robbyrussell/oh-my-zsh path:plugins/gitignore
antibody bundle robbyrussell/oh-my-zsh path:plugins/virtualenv
# antibody bundle owenstranathan/pipenv.zsh
# antibody bundle MichaelAquilina/zsh-autoswitch-virtualenv
antibody bundle robbyrussell/oh-my-zsh path:plugins/django
antibody bundle robbyrussell/oh-my-zsh path:plugins/pip
# Keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char

function cheat(){
curl cheat.sh/$1
}

function ls(){
    if [ -n "$1" ]; then
      lsd $1 -F --group-dirs first
    else
      lsd -F --group-dirs first
    fi
}

# Theme
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  venv          # virtualenv
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
# Simplify prompt if we're using Hyper
if [[ "$TERM_PROGRAM" == "Hyper" ]]; then
  SPACESHIP_PROMPT_SEPARATE_LINE=false
  SPACESHIP_DIR_SHOW=false
  SPACESHIP_GIT_BRANCH_SHOW=false
fi
antibody bundle denysdovhan/spaceship-prompt
# Open new tabs in same directory
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
  function chpwd {
    printf '\e]7;%s\a' "file://$HOSTNAME${PWD// /%20}"
  }
  chpwd
fi

PATH=$PATH:/snap/bin:$HOME/.bin

NPM_PACKAGES="${HOME}/.npm-packages"

export PATH="$PATH:$NPM_PACKAGES/bin"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
