include config.mk

TOOL=.tools/archlinux

ARCH_GUI_TOOLS=firefox bitwarden vlc vlc-plugins-all
ARCH_CLI_TOOLS=xsecurelock rclone yt-dlp mpv
ARCH_DEVEL_TOOLS=coreutils base-devel
ARCH_JAVA_TOOLS=jdk21-openjdk openjdk21-src
ARCH_AUR_TOOLS=kew sesh brave-bin oxwm-git
ARCH_COMMON_DOTFILES=\
	alacritty ghostty kitty \
	bat yazi \
	git lazygit \
	helix lazyvim vim oxwm \
	tmux sesh ssh \
	zsh-commons zsh-antidote

ARCH_FONTS=\
	ttf-ibmplex-mono-nerd \
	ttf-nerd-fonts-symbols \
	ttf-nerd-fonts-symbols-mono \
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

ARCH_X11_TOOLS=\
	xorg-xinit imagemagick \
	xclip brightnessctl xbindkeys libnotify dunst playerctl \
	picom \
	nsxiv feh \
	python-pywal

yay = yay -Sy $(1)
pacman = sudo pacman -Sy $(1)

define dotfiles-install
	mkdir -p enabled
	stow -d available -t enabled $^
	stow --dotfiles enabled
endef

$(TOOL).yay:
	$(call if-command,yay,$@) || \
		[ -d /tmp/yay ] && rm -fr /tmp/yay && \
		git clone https://aur.archlinux.org/yay.git /tmp/yay && \
		cd /tmp/yay && makepkg -si && \
		$(run-once)

$(TOOL).X11:
	$(call pacman, xorg xorg-apps)
	sudo rm -fr /etc/X11/xorg.conf.d/00-keyboard.conf
	sudo stow -t / arch
	$(run-once)

$(TOOL).X110

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

#
# SUCKLESS
#
SUCKLESS_TOOLS=dmenu dwm slock slstatus st

SUCKLESS_DEPS=\
	$(COMMON_TOOLS) \
  $(COMMON_TERMINALS) \
	$(ARCH_CLI_TOOLS)
	$(ARCH_X11_TOOLS) \
	$(ARCH_FONTS) \
	$(ARCH_VIDEO_DRIVER_TOOLS)

suckless/%:
	cd apps/$* && DESTDIR=~/.local make clean install

$(TOOL).suckless-build: $(addprefix suckless/,$(SUCKLESS_TOOLS))

$(TOOL).suckless-deps:
	$(call pacman, $(SUCKLESS_DEPS))
	$(run-once)

$(TOOL).suckless: $(addprefix $(TOOL).,yay ly X11 aur suckless-deps suckless-build)

#
# OXWM
# 
OXWM_DOTFILES = $(ARCH_COMMON_DOTFILES) $(ARCH_DWM_DOTFILES)

$(TOOL).oxwm: $(addprefix $(TOOL).,bluetooth suckless)
	$(call pacman, $(DWM_DEPS))
	$(MAKE) suckless
	$(call dotfiles, $(DWM_DOTFILES))
	$(run-once)

#
# DWM
#
ARCH_DWM_DOTFILES=picom x11-dwm wal

DWM_DEPS=\
	$(COMMON_TOOLS) \
  $(COMMON_TERMINALS) \
	$(ARCH_CLI_TOOLS)
	$(ARCH_X11_TOOLS) \
	$(ARCH_FONTS) \
	$(ARCH_VIDEO_DRIVER_TOOLS)
DWM_DOTFILES=$(ARCH_COMMON_DOTFILES) $(ARCH_DWM_DOTFILES)

$(TOOL).dwm: $(addprefix $(TOOL).,yay ly X11 bluetooth aur dwm-deps) suckless
	$(call dotfiles, $(DWM_DOTFILES))
	$(run-once)

$(TOOL).dwm-deps:
	$(call pacman, $(DWM_DEPS))

#
# WAYLAND + HYPRLAND
# 
HYPRLAND_DEPS=hyprland xorg-xwayland \
							hyprpaper kyprlock hypridle hyprpicker\
							wofi waybar dolphin wl-clipboard cliphist \
							grim slurp matugen
HYPRLAND_DOTFILES=$(ARCH_COMMON_DOTFILES) arch_hyprland wallpapers
$(TOOL).hyprland: $(addprefix $(TOOL).,yay ly aur)
	$(call pacman, $(HYPRLAND_DEPS))
	$(call yay, dms-shell-bin)
	$(call dotfiles, $(HYPRLAND_DOTFILES))
	$(run-once)

#
# Gnome
# 

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


