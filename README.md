# Dotfiles

This repository contains portable, security-conscious dotfiles intended for use in:

- Development containers
- CI environments
- Remote Linux hosts

These dotfiles intentionally avoid:

- OS-specific behavior (macOS, Homebrew, iTerm, etc.)
- Hidden command behavior
- Secrets or credentials of any kind

If you are looking for convenience shortcuts or shell customization, this is not the place.

## Design Goals

- Consistency across development environments, CI, and remote hosts
- Predictability over convenience
- Safety when working with Docker, Kubernetes, and Terraform
- Minimal maintenance overhead

These dotfiles should "disappear" once installed.

## What Belongs Here

✅ Portable shell configuration  
✅ Read-only or shortening aliases  
✅ Context visibility helpers  
✅ Git defaults  
✅ Tool-agnostic environment variables

## What Does Not Belong Here

❌ Secrets, API keys, tokens, certificates  
❌ Context-switching shortcuts (prod/dev)  
❌ Destructive command aliases  
❌ Editor-specific configuration (.cursor, .claude, etc.)  
❌ Host-specific customization (macOS, Windows, WSL, Homebrew)

## Safe Alias Policy

This repository follows a strict safe alias policy.

### Allowed Aliases

Aliases may:

- Shorten commands (k → kubectl)
- Provide read-only views (kubectl get …)
- Reveal execution context

**Examples:**

```bash
alias k='kubectl'
alias kgp='kubectl get pods'
alias kctx='kubectl config current-context'
alias tfp='terraform plan'
alias dps='docker ps'
```

### Forbidden Aliases

Aliases must never:

- Run destructive commands
- Switch contexts or namespaces
- Hide flags or defaults
- Assume production access

**Forbidden examples:**

```bash
alias kdel='kubectl delete'
alias tfapply='terraform apply -auto-approve'
alias useprod='kubectl config use-context prod'
```

> **Warning:** If an alias makes it easier to damage infrastructure, it does not belong here.

## Repository Structure

```text
dotfiles/
├─ install.sh
├─ bash/
│  ├─ bashrc
│  ├─ aliases.sh
│  ├─ functions.sh
│  └─ env.sh
├─ zsh/
│  ├─ zshrc
│  ├─ aliases.sh
│  ├─ functions.sh
│  └─ env.sh
├─ git/
│  ├─ gitconfig
│  └─ gitignore_global
├─ docker/
│  └─ config.json
├─ terraform/
│  └─ terraformrc
├─ editor/
│  └─ editorconfig
├─ docs/
│  └─ SETUP_SSH_SIGNING.md
├─ .gitignore
├─ CHANGELOG.md
├─ LICENSE
└─ README.md
```

The `aliases.sh` file includes a header restating the safe alias policy.

## Shell Support

- **Shells:** bash and zsh
- **Platform:** Linux containers
- **Interactive behavior only** (no login shell hacks)

The install script automatically detects your current shell and installs the appropriate configuration. Both bash and zsh configurations provide the same functionality and follow the same safe alias policy.

These dotfiles are not intended to replace your local shell configuration.

## Usage

This repository can be used with development container tools that support dotfiles:

```json
"dotfiles": {
  "repository": "https://github.com/your-org/dotfiles"
}
```

Or install manually by running the `install.sh` script:

```bash
./install.sh
```

These dotfiles are safe to apply to any repository without modification.

## Initial Setup

After installation, you may need to configure:

- **Git user info**: Set via environment variables before installation:
  ```bash
  export GIT_USER_NAME="Your Name"
  export GIT_USER_EMAIL="your.email@example.com"
  ./install.sh
  ```
  
  Or configure manually after installation:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your.email@example.com"
  ```
- **Docker config**: The Docker config is automatically linked to `~/.docker/config.json`

## Secrets & Security

This repository must never contain secrets.

All credentials must be provided via:

- Environment variables
- External secret managers
- Per-project configuration

If a file might contain sensitive information, it should:

- Live outside this repo
- Be ignored by `.gitignore`

## Philosophy

These dotfiles are intentionally conservative.

- **Friction is a safety feature**
- **Explicit is better than convenient**
- **Production deserves respect**

If you miss something twice, consider adding it.  
If it could break prod, don't.

### Before Adding Anything New

Ask:

> Would this make it easier to do something dangerous accidentally?

If the answer is **yes** — or **maybe** — it doesn't belong here.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Use freely.  
Modify carefully.
