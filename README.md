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
sudo port install alacritty
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

