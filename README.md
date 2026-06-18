# Dotfiles

## NixOS (Flakes)

### First-time setup

Clone the dotfiles, then bootstrap with flakes enabled on-the-fly:

```shell
git clone <repo> ~/dotfiles
sudo nixos-rebuild switch \
  --flake ~/dotfiles/nixos#nixos \
  --extra-experimental-features "nix-command flakes"
```

After this, flakes are enabled system-wide. Subsequent rebuilds:

```shell
sudo nixos-rebuild switch --flake ~/dotfiles/nixos
```

### SSH Keys

```shell
make ssh
```

Outputs public keys — paste each into the respective account settings:
- GitHub: Settings → SSH and GPG keys → New SSH key
- Codeberg: Settings → SSH / GPG Keys

### OneDrive sync (rclone)

```shell
# 1. Configure remote (interactive, one-time)
rclone config   # name: onedrive · type: Microsoft OneDrive · personal account

# 2. Initial baseline sync (one-time per folder)
rclone bisync ~/Music onedrive:Music --resync --create-empty-src-dirs
rclone bisync ~/Pictures onedrive:Pictures --resync --create-empty-src-dirs

# 3. Enable auto-sync timers
systemctl --user enable --now rclone-bisync-music.timer rclone-bisync-pictures.timer
```

---

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
sudo zypper install  zsh tmux neovim helix stow git lazygit bat eza fd fzf jq ripgrep curl wget aria2 
```

### Additional setup

- [Coursier](https://get-coursier.io/docs/cli-installation)
