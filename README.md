# Dotfiles

## Mac OS

### Prerequisitives

#### Command Line Developer Tools

```shell
xcode-select --install
```

#### Package manager 

* [Homebrew](https://brew.sh/) (for up-to-date Mac OS)
* [Macports](https://www.macports.org/install.php) (if homebrew is not a choice)

#### Setup

```shell
# In case Homebrew
make mac/brew

# In case Macports
make mac/ports
```

## Linux 

```shell
make 
```

## WSL 

```shell
sudo zypper install \
    zsh tmux neovim helix \
		stow git lazygit \
		bat eza fd fzf jq ripgrep \
    curl wget aria2 
```

### Additional setup

- [Coursier](https://get-coursier.io/docs/cli-installation)

