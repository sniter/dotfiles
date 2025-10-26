include config.mk

TOOL=.tools/archlinux

ARCH_GUI_TOOLS=firefox bitwarden
ARCH_CLI_TOOLS=rclone yt-dlp
ARCH_DEVEL_TOOLS=coreutils base-devel
ARCH_JAVA_TOOLS=jdk21-openjdk openjdk21-src
SUCKLESS_TOOLS=dmenu dwm slock slstatus st
ARCH_AUR_TOOLS=kew sesh
ARCH_DWM_DOTFILES=picom x11-dwm wal 
ARCH_COMMON_DOTFILES=\
	alacritty ghostty kitty \
	bat yazi \
	git lazygit \
	helix lazyvim vim \
	tmux sesh ssh \
	zsh-commons zsh-antidote

ARCH_FONTS=\
	ttc-iosevka \
	ttf-iosevkaterm-nerd \
	ttf-ibmplex-mono-nerd \
	ttf-ibm-plex \
	noto-fonts-emoji \
	ttf-font-awesome

ARCH_VIDEO_DRIVER_TOOLS=\
	mesa mesa-utils \
	vulkan-intel vulkan-tools \
	libva-intel-driver libva-utils \
	xf86-video-intel intel-media-driver

ARCH_DWM_TOOLS=\
	xorg-xinit \
	xclip brightnessctl xbindkeys libnotify dunst playerctl \
	picom \
	nsxiv feh \
	python-pywal

define yay-install
	yay -Sy $^
endef

define pacman-install
	sudo pacman -Sy $^
endef

define dotfiles-install
	mkdir -p enabled
	stow -d available -t enabled $^
	stow --dotfiles enabled
endef

define run-once
	mkdir -p $(dir $@) && echo "$^" > $@
endef

if-command = command -v $< >/dev/null 2>&1 && mkdir -p $(dir $@) && echo "$^" > $@ 
endef

suckless/%:
	cd apps/$* && DESTDIR=~/.local make clean install

suckless: $(addprefix suckless/,$(SUCKLESS_TOOLS))

$(TOOL).yay: yay
	$(if-command) || \
		[ -d /tmp/yay ] && rm -fr /tmp/yay && \
		git clone https://aur.archlinux.org/yay.git /tmp/yay && \
		cd /tmp/yay && makepkg -si && \
		$(run-once)

$(TOOL).X11: xorg xorg-apps 
	$(pacman-install)
	sudo rm /etc/X11/xorg.conf.d/00-keyboard.conf
	sudo stow -t / arch
$(run-once)

$(TOOL).ly: ly
	$(pacman-install)
	sudo systemctl enable ly.service
	sudo systemctl disable getty@.service
	$(run-once)

$(TOOL).bluetooth: bluez bluez-tools
	$(pacman-install)
	sudo systemctl enable bluetooth.service
	sudo systemctl start bluetooth.service
	$(run-once)

$(TOOL).aur: $(ARCH_AUR_TOOLS)
	$(yay-install)
	$(run-once)

$(TOOL).dwm: $(addprefix $(TOOL).,yay ly X11 bluetooth aur dwm.pacman dwm.dotfiles)
	$(run-once)

$(TOOL).dwm.dotfiles: $(ARCH_COMMON_DOTFILES) $(ARCH_DWM_DOTFILES)
	$(dotfiles-install)
	$(run-once)

$(TOOL).dwm.pacman: \
	$(COMMON_TOOLS) \
  $(COMMON_TERMINALS) \
	$(ARCH_DWM_TOOLS) \
	$(ARCH_FONTS) \
	$(ARCH_VIDEO_DRIVER_TOOLS)
	$(pacman-install)

$(TOOL).gnome: gnome
	$(pacman-install)
	dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:caps_toggle','terminate:ctrl_alt_bksp']"
	sudo systemctl enable gdm.service

$(TOOL).kde: plasma-desktop
	$(pacman-install)
	sudo systemctl enable sddm.service
	sudo systemctl start sddm.service

$(TOOL).sway: $(addprefix $(TOOL).,yay ly X11 sway.pacman dwm.aur dwm.dotfiles)

$(TOOL).sway.pacman: sway swaylock swayidle swaybg brightnessctl
	$(pacman-install)
	$(run-once)

$(TOOL).sway.dotfiles: $(ARCH_COMMON_DOTFILES) sway
	$(dotfiles-install)
	$(run-once)


