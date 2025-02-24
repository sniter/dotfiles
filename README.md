# Dotfiles

## Prerequisitives

### Command Line Developer Tools

```shell
xcode-select --install
```

### Package manager 

* [Homebrew](https://brew.sh/) (for up-to-date Mac OS)

```shell 
brew install \
    neovim helix \
    fzf the_silver_searcher ripgrep fd \
    aria2c bat eza stow tmux 
```

* [Macports](https://www.macports.org/install.php) (if homebrew is not a choice)

```shell 
sudo port install \
    neovim helix \
    fzf the_silver_searcher ripgrep fd \
    aria2 bat eza stow tmux 
    
```

### Fonts

```shell
brew install font-fira-mono-nerd-font
```

### Terminal emulator

**In Homebrew**

```shell
brew install --cask alacritty
brew install --cask wezterm
brew install --cask kitty
```

**In MacPorts**

```shell
sudo port install alacritty
sudo port install wezterm
sudo port install kitty
```

### Programming languages

**In Homebrew**

```shell
brew install \
    rust \
    opam \
    haskell-stack \
    coursier
brew install --cask oracle-jdk
```
**In MacPorts**

```shell
sudo port install \
    rust rust-src \
    opam \
    stack \
    openjdk21-oracle
```
Coursier should be installed [manually](https://get-coursier.io/docs/cli-installation#macos).

## Emacs

```shell
brew tap d12frosted/emacs-plus
brew install emacs-plus \
    --with-native-comp \
    --with-savchenkovaleriy-big-sur-3d-icon
```

## Linux Setup

```shell
sudo pacman -S \
    stow git openssh neovim\
    alacritty aria2 bat eza fd fzf jq htop less ripgrep starship tmux \
    firefox chromium \
    noto-fonts-emoji ttc-iosevka-nerd ttf-font-awesome ttf-firacode-nerd \
    jdk21-openjdk openjdk21-src \

```
