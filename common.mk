include config.mk
########################################################################################
# 
# COMMON
#
########################################################################################
common/zsh/default:
	@ZSH_PATH=$$(which zsh) && \
	echo "Changing shell to $$ZSH_PATH" && \
	chsh -s $$ZSH_PATH

common/ssh/github:
	mkdir -p ~/.ssh/github.com/git
	ssh-keygen -t ed25519 -C "sniter@gmail.com" -f ~/.ssh/github.com/git/id_ed25519
	cat ~/.ssh/github.com/git/id_ed25519.pub


ssh: $(addprefix ssh/,github codeberg)

ssh/github:
	$(call SSH_KEYGEN,github.com,git,ed25519,$(GIT_EMAIL))

ssh/codeberg:
	$(call SSH_KEYGEN,codeberd.org,git,ed25519,$(GIT_EMAIL))



