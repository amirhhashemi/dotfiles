# Dotfiles

This repository contains my personal dotfiles managed with GNU Stow.

> [!NOTE]  
> This repository is intended for personal use and contains configurations tailored to my specific needs and preferences. However, feel free to use these dotfiles as inspiration or directly if you find them helpful. Just be aware that you may need to modify some configurations to suit your own setup and preferences.

## Contents

- `bin/`: Custom scripts and executables
- `fish/`: Fish shell configuration
- `git/`: Git configuration
- `ideavim/`: IdeaVim configuration for JetBrains IDEs
- `kitty/`: Kitty terminal emulator configuration
- `nvim/`: Neovim configuration
- `systemd/`: Custom systemd service files
- `zellij/`: Zellij terminal multiplexer configuration

## Prerequisites

- GNU Stow

## Installation

1. Clone this repository:

```sh
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
```

2. Change to the dotfiles directory:

```sh
cd ~/.dotfiles
```

3. Use stow to symlink the configurations you want. For example:

```sh
stow fish
stow nvim
stow kitty
```

This will create symlinks in your home directory for the respective configurations.

4. Make scripts executable:

```sh
chmod +x ~/.dotfiles/bin/*
```

This step is necessary to ensure that custom scripts in the `bin/` directory are executable.

5. Enable systemd services:

If you've included any custom systemd service files in the `systemd/` directory, you'll need to enable and start them manually. For example:

```sh
systemctl --user enable --now theme-updater.service
```
