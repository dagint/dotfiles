# Changelog

All notable changes to this dotfiles repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Git configuration via environment variables**: 
  - `install.sh` now sets `user.name` and `user.email` from `GIT_USER_NAME` and `GIT_USER_EMAIL` environment variables
  - Allows automated setup in CI/CD and development containers without manual configuration
- **Gap analysis enhancements**:
  - PATH manipulation for `~/bin` and `~/.dotfiles/bin` directories (automatically added if they exist)
  - Git branch display in prompt via `parse_git_branch()` function (read-only, safe)
  - `umask 0002` setting for shared development environments
  - Additional safe git aliases: `lg` (pretty log), `recent-branches`, `latest-remote`, `latest` (all read-only)
  - Shell logout scripts: `bash/bash_logout` and `zsh/zlogout` (clear screen on logout for privacy)
  - Terraform provider mirror configuration example (commented, for organization-specific mirrors)
- zsh support with equivalent configuration files:
  - `zsh/zshrc` - zsh configuration with zsh-specific options
  - `zsh/aliases.sh` - Same safe aliases as bash version
  - `zsh/functions.sh` - Same safe functions as bash version
  - `zsh/env.sh` - Environment variables (zsh-specific adjustments)
- Shell detection in `install.sh` to automatically install bash or zsh configuration
- Updated README to document both bash and zsh support
- direnv hook integration in `bashrc` for automatic environment variable loading
- Safe helper functions in `bash/functions.sh` for context visibility
  - `kctx-info()` - Show Kubernetes context and namespace
  - `tf-info()` - Show Terraform workspace and directory
  - `dctx-info()` - Show Docker context
  - `ctx-info()` - Show all context information
  - `path-prepend()` / `path-append()` - Safe PATH manipulation
- Additional read-only Git aliases: `glog`, `gdiff`, `gbr`, `gbrr`, `gshow`, `gls`
- Additional read-only Terraform aliases: `tfl`, `tfv`, `tff`
- Additional read-only Kubernetes aliases: `kgd`, `kgi`, `kgc`, `kgsec`, `kdesc`, `klogs`, `kctxs`
- Additional read-only Docker aliases: `dpsa`, `dvol`, `dnet`, `dinfo`, `dver`, `dctx`, `dctxs`, `dcl`, `dcps`
- System info aliases: `df`, `du`, `free` (with human-readable flags)
- Network alias: `ports` (read-only netstat)
- Enhanced `bashrc` with safer defaults:
  - History timestamps and deduplication
  - `noclobber` to prevent accidental overwrites
  - Additional shell safety options
- Enhanced `env.sh` with locale, timezone, and better `less` configuration
- Improved `install.sh` with better error handling and automatic dotfiles detection
- `.gitignore` file to exclude editor and OS-specific files
- `CHANGELOG.md` for tracking changes
- `LICENSE` file

### Changed
- Updated README structure to match actual file organization
- Enhanced bashrc history settings for better usability
- Improved install script with validation and better error messages
- Docker Compose aliases (`dcu`, `dcd`) now include explanatory comments
- Completely reorganized `gitignore_global` with:
  - Clear category sections with descriptive headers
  - Removed duplicate patterns
  - Expanded coverage for secrets, IaC, dependencies, editors, OS files, build artifacts, logs, databases, testing, and documentation
  - Better organization and readability

### Fixed
- Removed duplicate Kubernetes aliases (`kgp`, `kgs`, `kgn`)
- Removed personal information from `gitconfig` (replaced with placeholders)
- Updated README to reflect actual repository structure
- Added Docker config installation to `install.sh`

## [1.0.0] - Initial Release

### Added
- Basic bash configuration (`bashrc`, `aliases.sh`, `env.sh`)
- Git configuration (`gitconfig`, `gitignore_global`)
- Terraform configuration (`terraformrc`)
- Docker configuration (`config.json`)
- Editor configuration (`editorconfig`)
- Installation script (`install.sh`)
- README documentation
