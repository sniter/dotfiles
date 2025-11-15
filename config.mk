COMMON_TOOLS=\
	zsh \
	helix neovim vim emacs \
	stow git lazygit \
	atop btop htop \
	wget aria2 curl \
	bat eza fd fzf jq less ripgrep tmux zoxide

COMMON_TERMINALS=alacritty kitty ghostty

GIT_EMAIL=$(shell echo c25pdGVyQGdtYWlsLmNvbQo= | base64 -d)

SSH_KEYGEN=\
	mkdir -p ~/.ssh/$(1)/$(2) && \
	ssh-keygen -t $(3) -C "$(4)" -f ~/.ssh/$(1)/$(2)/id_$(3) && \
	cat ~/.ssh/$(1)/$(2)/id_$(3).pub

if-command = command -v $(1) >/dev/null 2>&1 && mkdir -p $(dir $(2)) && echo "$(1)" > $(2) 
service-enable = sudo systemctl enable $(1).service
service-disable = sudo systemctl disable $(1).service
service-start = sudo systemctl start $(1).service
dotfiles = mkdir -p enabled && stow -d available -t enabled $(1) && stow --dotfiles enabled

define run-once
	mkdir -p $(dir $@) && echo "$^" > $@
endef

