;;; post-init.el -- POST-INIT -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Basic
(when (eq system-type 'windows-nt)
  (require 'ms-windows))

;; Must Have
(setq visible-bell t)
(setq ring-bell-function 'default)

(setq scroll-preserve-screen-position nil)

(defun rc-basic/prog ()
  (setq-local show-trailing-whitespace t ;display trail-space like in nano
	          indicate-empty-lines t     ;display non-CR line in the fringe
	          display-line-numbers-width 3)
  (display-line-numbers-mode :toggle)
  (electric-pair-mode t))

(add-hook 'prog-mode-hook #'rc-basic/prog)


(which-key-mode t)
(global-completion-preview-mode t)
(blink-cursor-mode t)

;; Delete selection
(use-package delsel
  :ensure nil                           ;since its builtin
  :hook (after-init . delete-selection-mode))

;; Sensible Binding
(global-set-key (kbd "C-S-k") 'kill-whole-line)	     ; Essential
(global-set-key (kbd "C-x M-o") 'window-swap-states) ; Essential


(defun split-recent-buffer ()
  "Split recent buffers, unless switch to it"
  (interactive)
  (switch-to-buffer-other-window (other-buffer (current-buffer) t)))

(global-set-key (kbd "C-x B") 'split-recent-buffer) ; Fun


;;; Rendering
(require 'rendering)

;;; Essential
(require 'essential)

;;; MiniBuffer
(require 'my-minibuffer)

;;; Language
(require 'language)

;;; Dired
(require 'my-dired)

;;; VC
(require 'my-vc)

;;; TTY
(require 'my-tty)
