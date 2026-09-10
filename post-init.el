;;; post-init.el -- POST-INIT -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Basic
(require 'ms-windows)

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
(use-package magit
  :bind
  ("C-x g" . magit-status))


(use-package diff-hl
  :commands (diff-hl-mode
             global-diff-hl-mode)
  :hook (prog-mode . diff-hl-mode)
  :init
  (setq diff-hl-flydiff-delay 0.4)  ; Faster
  (setq diff-hl-show-staged-changes nil)  ; Realtime feedback
  (setq diff-hl-update-async t)  ; Do not block Emacs
  (setq diff-hl-global-modes '(not pdf-view-mode image-mode)))


;;; TTY
(require 'my-tty)
