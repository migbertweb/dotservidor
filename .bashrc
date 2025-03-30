#!/bin/bash
# ~/.bashrc - Configuración optimizada para servidores

# --- Configuración de Terminal ---
export TERM=xterm-256color
export XTERM=${TERM}

# --- Configuración básica ---
export VISUAL="vim"
export EDITOR="vim"

# Seguridad: Ignorar comandos sensibles en el historial
export HISTIGNORE="*sudo -S*:ls:pwd:exit:sudo reboot:history"
export HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=5000
shopt -s histappend

# --- PATH adicional ---
#[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# --- Promt para sudo ---
export SUDO_PROMPT="Deploying root access for %u. Password pls: "

# --- Aliases generales ---
alias cl='clear'
alias v='vim'

# Mejores comandos ls (exa o ls normal)
if command -v exa &>/dev/null; then
	alias ls='exa --long --color=auto --icons --git --sort=type'
	alias la='exa --long --all --color=auto --icons --git --sort=type'
else
	alias ls='ls --color=auto'
	alias la='ls -la --color=auto'
fi

# Bat (cat mejorado)
if command -v bat &>/dev/null; then
	alias cat='bat --theme=Dracula'
	export BAT_THEME="Dracula"
fi

# --- Docker Aliases ---
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dimg='docker images --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}"'
alias dlogs='docker logs -f'
alias dcompose='docker-compose'

# --- Kubernetes Aliases ---
alias k='kubectl'
alias kgp='kubectl get pods -o wide'
alias kgn='kubectl get nodes -o wide'
alias klog='kubectl logs -f'

# --- Funciones útiles ---
mkcd() {
	mkdir -p "$1" && cd "$1"
}

gitpush() {
	git add -v .
	git commit -m "$1"
	git push
	git log -5 --graph --oneline --abbrev-commit --pretty=format:"%h - %an, %ar : %s"
}
alias gitu='gitpush'

# --- Prompt Avanzado ---
parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Colores para SSH/local
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	PS1_HOST_COLOR='\[\033[1;31m\]' # Rojo para SSH
	PS1_SUDO_ICON='⚡'               # Icono para SSH
else
	PS1_HOST_COLOR='\[\033[1;32m\]' # Verde para local
	PS1_SUDO_ICON=''
fi

# Prompt con: user@host, path, git, estado, y privilegios
PS1="\n${PS1_HOST_COLOR}\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[33m\]\$(parse_git_branch)\n\
\[\033[1;31m\]\${?#0}\[\033[0m\]-\
[\$(if [[ \$(id -u) -eq 0 ]]; then echo '\[\033[1;31m\]ROOT\[\033[0m\]'; else echo '\[\033[1;32m\]USER\[\033[0m\]'; fi)]\
${PS1_SUDO_ICON} \$ "

# --- Integración con herramientas ---
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init --cmd cd bash)"
fi

# Autocompletado
if ! shopt -oq posix; then
	[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
	[ -f /etc/bash_completion ] && source /etc/bash_completion
fi

# --- Navegación con fzf ---
if command -v fzf &>/dev/null; then
	cd() {
		if [[ $# -eq 0 ]]; then
			local dir
			dir=$(find . -type d 2>/dev/null | fzf --height 40% --reverse --preview 'ls -lh {}') && builtin cd "$dir"
		else
			builtin cd "$@"
		fi
	}
fi

# --- Mensaje inicial ---
clear
echo -e "\e[1;34m=== Terminal Configurada ===\e[0m"
echo -e "Usuario: \e[32m$(whoami)\e[0m"
echo -e "Host: \e[32m$(hostname)\e[0m"
echo -e "Sesión SSH: \e[33m$([ -n "$SSH_CLIENT" ] && echo "ACTIVA" || echo "local")\e[0m"
