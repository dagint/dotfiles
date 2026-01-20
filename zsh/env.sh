# Set umask for shared development (group writable)
umask 0002

# Prevent accidental use of production
export TF_IN_AUTOMATION=1
export AWS_PAGER=""

# Safe defaults
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Prevent noisy logs
export ZSH_DISABLE_COMPFIX=true

# Language and locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Timezone (can be overridden)
export TZ="${TZ:-UTC}"

# Less with colors and better defaults
export LESS='-R -X -F'

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
