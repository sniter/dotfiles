include config.mk
########################################################################################
# 
# WSL
#
########################################################################################
TOOL=.tools/wsl.tumbleweed

WSL_DEPS=git make gcc cmake tar binutils \
	$(COMMON_TOOLS)

WSL_DOTFILES=\
	bat yazi \
	git lazygit \
	helix lazyvim vim \
	tmux sesh ssh \
	zsh-commons zsh-antidote

zypper = sudo zypper install $(1)

$(TOOL).default:
	$(call zypper, $(WSL_DEPS))
	$(call dotfiles, $(WSL_DOTFILES))
	$(run-once)

install: $(addprefix $(TOOL).,default)
