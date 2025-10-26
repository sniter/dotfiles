COMMON_TOOLS=\
	zsh \
	helix neovim vim \
	stow git lazygit \
	atop btop htop \
	wget aria2 curl \
	bat eza fd fzf jq less ripgrep tmux zoxide

COMMON_TERMINALS=alacitty kitty ghostty

GIT_EMAIL=$(shell echo c25pdGVyQGdtYWlsLmNvbQo= | base64 -d)

# common/ssh/github:
# 	mkdir -p ~/.ssh/github.com/git
# 	ssh-keygen -t ed25519 -C "sniter@gmail.com" -f ~/.ssh/github.com/git/id_ed25519
# 	cat ~/.ssh/github.com/git/id_ed25519.pub

SSH_KEYGEN=\
	mkdir -p ~/.ssh/$(1)/$(2) && \
	ssh-keygen -t $(3) -C "$(4)" -f ~/.ssh/$(1)/$(2)/id_$(3) && \
	cat ~/.ssh/$(1)/$(2)/id_$(3).pub

