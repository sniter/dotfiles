(setq custom-file "~/.emacs.d/custom.el")
(tool-bar-mode 1)
(menu-bar-mode 1)
(scroll-bar-mode 1)
;(column-number-mode 1)
(show-paren-mode 1)
(global-display-line-numbers-mode)
(setq inhibit-startup-screen t)

;; font
(add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font Mono" ))
(set-face-attribute 'default t :font "FiraCode Nerd Font Mono" )

;; MacOS
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)

;; Theme
(load-theme 'wombat)
