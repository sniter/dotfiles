include config.mk

TOOL=.tools/archlinux

ARCH_GUI_TOOLS=firefox bitwarden
ARCH_CLI_TOOLS=xsecurelock rclone yt-dlp mpv markdownlint-cli2
ARCH_DEVEL_TOOLS=coreutils base-devel
ARCH_JAVA_TOOLS=jdk21-openjdk openjdk21-src
SUCKLESS_TOOLS=dmenu dwm slock slstatus st
ARCH_AUR_TOOLS=kew sesh brave-bin
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
	ttf-font-awesome \
	gnu-free-fonts \
	ttf-liberation \
	ttf-input-nerd \
	noto-fonts

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
	sudo pacman -Sy $@
endef

yay = yay -Sy $(1)
pacman = sudo pacman -Sy $(1)

define dotfiles-install
	mkdir -p enabled
	stow -d available -t enabled $^
	stow --dotfiles enabled
endef

suckless/%:
	cd apps/$* && DESTDIR=~/.local make clean install

suckless: $(addprefix suckless/,$(SUCKLESS_TOOLS))

$(TOOL).yay:
	$(call if-command,yay,$@) || \
		[ -d /tmp/yay ] && rm -fr /tmp/yay && \
		git clone https://aur.archlinux.org/yay.git /tmp/yay && \
		cd /tmp/yay && makepkg -si && \
		$(run-once)

$(TOOL).X11:
	$(call pacman, xorg xorg-apps)
	sudo rm /etc/X11/xorg.conf.d/00-keyboard.conf
	sudo stow -t / arch
	$(run-once)

$(TOOL).ly:
	$(call pacman, ly)
	$(call service-enable, ly)
	$(call service-disable, getty@)
	$(run-once)

$(TOOL).bluetooth:
	$(call pacman, bluez, bluez-tools)
	$(call service-enable, bluetooth)
	$(call service-start, bluetooth)
	$(run-once)

$(TOOL).aur:
	$(call yay $(ARCH_AUR_TOOLS))
	$(run-once)

DWM_DEPS=\
	$(COMMON_TOOLS) \
  $(COMMON_TERMINALS) \
	$(ARCH_DWM_TOOLS) \
	$(ARCH_FONTS) \
	$(ARCH_VIDEO_DRIVER_TOOLS)
DWM_DOTFILES=$(ARCH_COMMON_DOTFILES) $(ARCH_DWM_DOTFILES)
$(TOOL).dwm: $(addprefix $(TOOL).,yay ly X11 bluetooth aur)
	$(call pacman, $(DWM_DEPS))
	$(call dotfiles, $(DWM_DOTFILES))
	$(run-once)

$(TOOL).gnome:
	$(call pacman, gnome)
	dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:caps_toggle','terminate:ctrl_alt_bksp']"
	$(call service-enable,gdm)
	$(run-once)

$(TOOL).kde:
	$(call pacman, plasma-desktop)
	$(call service-enable,sddm)
	$(call service-start,sddm)
	$(run-once)

SWAY_DEPS=sway swaylock swayidle swaybg brightnessctl
SWAY_DOTFILES=$(ARCH_COMMON_DOTFILES) sway
$(TOOL).sway: $(addprefix $(TOOL).,yay ly aur)
	$(call pacman, $(SWAY_DEPS))
	$(call dotfiles, $(SWAY_DOTFILES))
	$(run-once)


