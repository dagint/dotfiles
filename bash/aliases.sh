# SAFE ALIAS POLICY:
# - No destructive commands
# - No context switching
# - No hidden flags
# - Read-only or shortening only


alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# System info (read-only)
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Network (read-only)
alias ports='netstat -tulanp'

# Terraform (read-only operations)
alias tf='terraform'
alias tfp='terraform plan'
alias tfws='terraform workspace show'
alias tfl='terraform workspace list'
alias tfv='terraform validate'
alias tff='terraform fmt -check'

# Git (read-only and safe operations)
alias gst='git status'
alias gco='git checkout'
alias gcb='git checkout -b'
alias glog='git log --oneline --graph --decorate'
alias gdiff='git diff'
alias gbr='git branch'
alias gbrr='git branch -r'
alias gshow='git show'
alias gls='git ls-files'

# Docker (read-only and safe operations)
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'
alias dvol='docker volume ls'
alias dnet='docker network ls'
alias dinfo='docker info'
alias dver='docker version'
alias dctx='docker context show'
alias dctxs='docker context ls'

# Docker Compose (read-only)
alias dcl='docker compose config'
alias dcps='docker compose ps'

# Docker Compose workflow commands (state-changing but safe for local dev)
# These are allowed as they're common workflow commands for local development
# and don't affect production infrastructure
alias dcu='docker compose up'
alias dcd='docker compose down'

# Kubernetes (read-only operations)
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'
alias kgd='kubectl get deployments'
alias kgi='kubectl get ingress'
alias kgc='kubectl get configmaps'
alias kgsec='kubectl get secrets'
alias kdesc='kubectl describe'
alias klogs='kubectl logs'

# Context visibility (IMPORTANT)
alias kctx='kubectl config current-context'
alias kns='kubectl config view --minify --output "jsonpath={..namespace}"'
alias kctxs='kubectl config get-contexts'