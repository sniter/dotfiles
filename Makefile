include config.mk
zsh:
	chsh -s /bin/zsh

ssh: $(addprefix ssh/,github codeberg)

ssh/github:
	$(call SSH_KEYGEN,github.com,git,ed25519,$(GIT_EMAIL))

ssh/codeberg:
	$(call SSH_KEYGEN,codeberg.org,git,ed25519,$(GIT_EMAIL))


