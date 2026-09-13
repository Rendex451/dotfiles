# ============ Окружение ============
export PATH="$HOME/go/bin:$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export GOPATH="$HOME/go"

# ============ История ============
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ============ Автодополнение ============
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# ============ Промпт ============
# Без внешних тем (starship и т.п. в bootstrap не ставится) — ветка git
# через встроенный vcs_info.
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
PROMPT='%F{cyan}%n@%m%f %F{blue}%~%f%F{yellow}${vcs_info_msg_0_}%f %# '

# ============ zoxide (умный cd с историей переходов) ============
eval "$(zoxide init zsh)"

# ============ fzf (fuzzy-поиск: Ctrl-R/Ctrl-T + автодополнение) ============
# --zsh сам генерирует нужную интеграцию, без завязки на путь установки,
# который отличается между apt и dnf (нужен fzf >= 0.48).
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# ============ Алиасы ============
alias vim='nvim'
alias vi='nvim'
alias ll='eza -la --icons --group-directories-first'
alias ls='eza --icons --group-directories-first'
alias lt='eza --tree --icons'
alias cat='bat --paging=never'
alias find='fd'
alias grep='rg'
alias du='dust'
alias top='btop'
alias lg='lazygit'
alias fm='vifm'
