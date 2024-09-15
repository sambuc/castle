# Lionel's Castle

This repository contains my personal profile configuration.

## Notes

### VIM

The configuration relies on Vundle and expects a Nerd Font.

### ZSH

The configuration relies on [Oh My Zsh](https://ohmyz.sh).

The target to install it is **not** automatically triggered at this time, even with `make all`.

### Host-specific config

You can add host specific configuration by adding named it the following way:

```sh
${hostname}.profile # Used by both zsh & bash
${hostname}.zshrc
${hostname}.bashrc
${hostname}.aliases # Used by both zsh & bash
```

If such files exist when you install the configuration files, symlink will be added and they will be automatically picked up by the configuration.
