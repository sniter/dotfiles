include config.mk
zsh:
	@ZSH_PATH=/bin/zsh && \
	echo "Changing shell to $$ZSH_PATH" && \
	chsh -s $$ZSH_PATH

ssh: $(addprefix ssh/,github codeberg)

ssh/github:
	$(call SSH_KEYGEN,github.com,git,ed25519,$(GIT_EMAIL))

ssh/codeberg:
	$(call SSH_KEYGEN,codeberd.org,git,ed25519,$(GIT_EMAIL))


