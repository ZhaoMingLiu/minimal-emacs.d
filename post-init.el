;;; post-init.el -- POST-INIT -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Basic
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

;; (use-package outline
;;   :ensure nil
;;   :hook ((prog-mode text-mode) . outline-minor-mode)
;;   :config
;;   (add-hook 'outline-minor-mode-hook #'outline-hide-other))


(add-hook 'package-menu-mode-hook #'hl-line-mode)

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
(use-package modus-themes
  :bind ("<f5>" . #'modus-themes-toggle)

  :custom
  ((modus-themes-bold-constructs nil)
   (modus-themes-italic-constructs t)
   (modus-themes-mixed-fonts t)
   (modus-themes-variable-pitch-ui nil))

  :custom-face
  ;; (show-paren-match ((t :underline nil
  ;;                       :weight semibold)))
  (region ((t :extend nil)))

  :config
  (setq modus-operandi-palette-overrides
        `((cursor "#4C566A")

          (fg-prompt cyan-faint)
          (bg-prompt bg-cyan-nuanced)

          (bg-completion bg-inactive)

          ,@modus-themes-preset-overrides-cooler))

  (setq modus-vivendi-tinted-palette-overrides
        `((bg-hl-line bg-cyan-subtle)
          (cursor red-faint)

          ,@modus-themes-preset-overrides-warmer))

  (setq modus-themes-common-palette-overrides
        '((fg-region unspecified)
          (bg-region bg-lavender)

          (border-mode-line-active bg-mode-line-active)
          (border-mode-line-inactive bg-mode-line-inactive)

	      ;; (bg-paren-match unspecified)
	      ;; (fg-paren-match unspecified)
	      ))


  (setq modus-themes-to-toggle '(modus-operandi modus-vivendi-deuteranopia))


  :init
  (setq modus-themes-include-derivatives-mode t))

(use-package modus-flexoki
  :vc (:url "https://github.com/dpassen/modus-flexoki"
            :rev :newest)
  :config
  (load-theme 'modus-flexoki-light :no-confirm))

;; Fonts
(unless (find-font (font-spec :name "Symbols Nerd Font Mono"))
  (nerd-icons-install-fonts "c:/Users/username/Desktop/"))

(set-face-attribute 'default nil :family "Zx Proto" :height 100 :weight 'normal)

(set-face-attribute 'font-lock-comment-face nil :font "Zx Proto::+ss01" :slant 'italic :underline t)

;; Utils
(use-package rainbow-delimiters :hook prog-mode)

(use-package goggles :hook ((prog-mode text-mode) . goggles-mode))

(use-package crystal-point :hook (after-init . crystal-point-enable))

;; (use-package vim-tab-bar :hook after-init)

;; (use-package breadcrumb :hook emacs-startup)

(use-package buffer-box
  :vc (:url "https://github.com/rougier/buffer-box.git" :rev :newest)
  :hook ((window-configuration-change) . (lambda ()
                                           (unless (minibufferp)
                                             (buffer-box-on)))))

(use-package nano-splash
  :vc (:url "https://github.com/rougier/nano-splash.git" :rev :newest)
  :custom
  (nano-splash-title " GNU EMACS")
  (nano-splash-subtitle "如是說")
  :hook (after-init . nano-splash))

;; (use-package nano-vertico
;;   :vc (:url "https://github.com/rougier/nano-vertico.git" :rev :newest)
;;   :hook (vertico-mode
;;          vertico-grid-mode
;;          vertico-buffer-mode
;;          vertico-multiform-mode
;;          vertico-reverse-mode
;;          vertico-indexed-mode
;;          vertico-prescient-mode))

;; (use-package nano-modeline
;;   :vc (:url "https://github.com/rougier/nano-modeline.git" :rev :newest)
;;   :custom
;;   (nano-modeline-position #'nano-modeline-footer)
;;   :config
;;   (add-hook 'prog-mode-hook            #'nano-modeline-prog-mode)
;;   (add-hook 'text-mode-hook            #'nano-modeline-text-mode)
;;   (add-hook 'org-mode-hook             #'nano-modeline-org-mode)
;;   (add-hook 'pdf-view-mode-hook        #'nano-modeline-pdf-mode)
;;   (add-hook 'mu4e-headers-mode-hook    #'nano-modeline-mu4e-headers-mode)
;;   (add-hook 'mu4e-view-mode-hook       #'nano-modeline-mu4e-message-mode)
;;   (add-hook 'elfeed-show-mode-hook     #'nano-modeline-elfeed-entry-mode)
;;   (add-hook 'elfeed-search-mode-hook   #'nano-modeline-elfeed-search-mode)
;;   (add-hook 'term-mode-hook            #'nano-modeline-term-mode)
;;   (add-hook 'xwidget-webkit-mode-hook  #'nano-modeline-xwidget-mode)
;;   (add-hook 'messages-buffer-mode-hook #'nano-modeline-message-mode)
;;   (add-hook 'org-capture-mode-hook     #'nano-modeline-org-capture-mode)
;;   (add-hook 'org-agenda-mode-hook      #'nano-modeline-org-agenda-mode))


;;; Essensial

;; Native compilation enhances Emacs performance by converting Elisp code into
;; native machine code, resulting in faster execution and improved
;; responsiveness.
;;
;; Ensure adding the following compile-angel code at the very beginning
;; of your `~/.emacs.d/post-init.el` file, before all other packages.
(use-package compile-angel
  :demand t
  :config
  ;; The following disables compilation of packages during installation;
  ;; compile-angel will handle it.
  (setq package-native-compile nil)

  ;; Set `compile-angel-verbose' to nil to disable compile-angel messages.
  ;; (When set to nil, compile-angel won't show which file is being compiled.)
  (setq compile-angel-verbose t)

  ;; The following directive prevents compile-angel from compiling your init
  ;; files. If you choose to remove this push to `compile-angel-excluded-files'
  ;; and compile your pre/post-init files, ensure you understand the
  ;; implications and thoroughly test your code. For example, if you're using
  ;; the `use-package' macro, you'll need to explicitly add:
  ;; (eval-when-compile (require 'use-package))
  ;; at the top of your init file.
  (push "/init.el" compile-angel-excluded-files)
  (push "/early-init.el" compile-angel-excluded-files)
  (push "/pre-init.el" compile-angel-excluded-files)
  (push "/post-init.el" compile-angel-excluded-files)
  (push "/pre-early-init.el" compile-angel-excluded-files)
  (push "/post-early-init.el" compile-angel-excluded-files)

  ;; A local mode that compiles .el files whenever the user saves them.
  ;; (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode)

  ;; A global mode that compiles .el files prior to loading them via `load' or
  ;; `require'. Additionally, it compiles all packages that were loaded before
  ;; the mode `compile-angel-on-load-mode' was activated.
  (compile-angel-on-load-mode 1))


;; Auto-revert in Emacs is a feature that automatically updates the
;; contents of a buffer to reflect changes made to the underlying file
;; on disk.
(use-package autorevert
  :ensure nil
  :init
  ;; (setq auto-revert-verbose t)
  (setq auto-revert-interval 3)
  (setq auto-revert-remote-files nil)
  (setq auto-revert-use-notify t)
  (setq auto-revert-avoid-polling nil)
  (global-auto-revert-mode 1))

;; Recentf is an Emacs package that maintains a list of recently
;; accessed files, making it easier to reopen files you have worked on
;; recently.
(use-package recentf
  :ensure nil
  :bind (("C-x C-r" . recentf-open)
         ("C-S-t"   . recentf-open-most-recent-file))
  :init
  (setq recentf-auto-cleanup (if (daemonp) 300 'never))
  (setq recentf-exclude
        (list "\\.tar$" "\\.tbz2$" "\\.tbz$" "\\.tgz$" "\\.bz2$"
              "\\.bz$" "\\.gz$" "\\.gzip$" "\\.xz$" "\\.zip$"
              "\\.7z$" "\\.rar$"
              "COMMIT_EDITMSG\\'"
              "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
              "-autoloads\\.el$" "autoload\\.el$"))
  ;; Enable `recentf-mode'
  (recentf-mode 1)

  :config
  (add-hook 'buffer-list-update-hook #'recentf-track-opened-file)

  ;; A cleanup depth of -90 ensures that `recentf-cleanup' runs before
  ;; `recentf-save-list', allowing stale entries to be removed before the list
  ;; is saved by `recentf-save-list', which is automatically added to
  ;; `kill-emacs-hook' by `recentf-mode'.
  (add-hook 'kill-emacs-hook #'recentf-cleanup -90))

;; savehist is an Emacs feature that preserves the minibuffer history between
;; sessions. It saves the history of inputs in the minibuffer, such as commands,
;; search strings, and other prompts, to a file. This allows users to retain
;; their minibuffer history across Emacs restarts.
(use-package savehist
  :ensure nil
  :init
  (setq history-length 300)
  (setq savehist-autosave-interval 600)
  (savehist-mode 1))

;; save-place-mode enables Emacs to remember the last location within a file
;; upon reopening. This feature is particularly beneficial for resuming work at
;; the precise point where you previously left off.
(use-package saveplace
  :ensure nil
  :init
  (setq save-place-limit 400)
  (save-place-mode 1))


(use-package undo-fu-session
  :config
  (setq undo-fu-session-compression
	    (when (eq system-type 'windows-nt) 'zst))
  (undo-fu-session-global-mode t))

(use-package undo-fu
  :bind (("C-z" . nil)
         ("C-z" . undo-fu-only-undo)
         ("C-S-z" . undo-fu-only-redo))
  :init
  (setq undo-fu-allow-undo-in-region t
	    undo-fu-ignore-keyboard-quit t))


;;; MiniBuffer

;; (use-package prescient
;;   :custom
;;   (completion-styles '(prescient basic))
;;   (prescient-filter-method '(literal initialism regexp prefix))
;;   (prescient-sort-full-matches-first t)
;;   :config
;;   ;; (setq completion-preview-sort-function #'prescient-completion-sort) ;intergrate with this
;;   (prescient-persist-mode))             ;persist minibuffer history

;; (use-package vertico-prescient
;;   :config
;;   (setq vertico-prescient-enable-sorting t)
;;   (vertico-prescient-mode)) ;apply to vertico

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package vertico
  :pin melpa
  :hook ((after-init . vertico-mode)
	     (minibuffer-setup . vertico-repeat-save))
  :bind
  (("M-q" . #'vertico-quick-insert)
   ("M-R" . #'vertico-repeat)
   ;; :map vertico-map
   ;; ("M-n" . #'vertico-repeat-next)
   ;; ("M-p" . #'vertico-repeat-previous))
   )
  :config
  (setq vertico-resize t)
  (setq completion-in-region-function #'consult-completion-in-region)

  (setq vertico-multiform-commands
        '((consult-line buffer)
          (consult-ripgrep buffer)
          (consult-imenu buffer indexed)
	      (consult-outline buffer)
	      (execute-extended-command reverse grid)))

  (setq vertico-multiform-categories
        '((file
           buffer
           (+vertico-transform-functions . +vertico-highlight-directory)
           (vertico-sort-function . sort-directories-first)
	       (vertico-buffer-display-action . (display-buffer-same-window)))))

  (vertico-multiform-mode)


  ;; Prompt indicator for `completing-read-multiple'.
  (when (< emacs-major-version 31)
    (advice-add #'completing-read-multiple :filter-args
                (lambda (args)
                  (cons (format "[CRM%s] %s"
                                (string-replace "[ \t]*" "" crm-separator)
                                (car args))
                        (cdr args)))))


  (defun sort-directories-first (files)
    ;; Still sort by history position, length and alphabetically
    (setq files (vertico-sort-history-length-alpha files))
    ;; But then move directories first
    (nconc (seq-filter (lambda (x) (string-suffix-p "/" x)) files)
           (seq-remove (lambda (x) (string-suffix-p "/" x)) files)))


  (defvar +vertico-transform-functions nil)

  (cl-defmethod vertico--format-candidate :around
    (cand prefix suffix index start &context ((not +vertico-transform-functions) null))
    (dolist (fun (ensure-list +vertico-transform-functions))
      (setq cand (funcall fun cand)))
    (cl-call-next-method cand prefix suffix index start))

  (defun +vertico-highlight-directory (file)
    "If FILE ends with a slash, highlight it as a directory."
    (if (string-suffix-p "/" file)
        (propertize file 'face 'marginalia-file-priv-dir) ; or face 'dired-directory
      file)))


(use-package consult
  :bind (
	     ("C-c i" . consult-info)
	     ;; Custom M-# bindings for fast register access
	     ("M-#" . consult-register-load)
	     ("M-'" . consult-register-store)
	     ("C-M-#" . consult-register)
	     ;; Other custom bindings
	     ("C-x b" . consult-buffer)
	     ;; M-g bindings in `goto-map'
	     ("M-g o" . consult-outline)
	     ("M-g f" . consult-flymake)
	     ("M-g g" . consult-goto-line)
	     ("M-g i" . consult-imenu)
	     )
  :hook (completion-list-mode . consult-preview-at-point-mode))


(use-package marginalia
  :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
  :init (marginalia-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))


;;; Language
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))


(use-package eglot
  :ensure nil
  :hook ((python-mode
	      python-ts-mode

	      lua-ts-mode

	      sh-mode
	      bash-ts-mode) . eglot-ensure))


(add-hook 'python-ts-mode-hook #'display-fill-column-indicator-mode)


;;; Dired
(use-package dired
  :ensure nil
  :defer t
  :custom
  ((insert-directory-program
    (when (eq system-type 'windows-nt) "ls.exe"))

   (ls-lisp-use-insert-directory-program
    (when (eq system-type 'windows-nt) t))

   (dired-listing-switches "-AlhGgL --group-directories-first"))
  :bind (:map dired-mode-map
	          ("K" . dired-kill-subdir)))


(use-package dirvish
  :pin melpa
  :ensure t
  :init
  (dirvish-override-dired-mode)
  :config
  (dirvish-side-follow-mode)
  :bind
  (("C-c j" . dirvish-dwim)
   ("C-c S" . dirvish-side)
   :map dirvish-mode-map
   ("?" . dirvish-dispatch)
   ("v" . dirvish-vc-menu))
  :hook
  (emacs-startup . dirvish-side))


(use-package nerd-icons-dired :hook dired-mode)

(setq delete-by-moving-to-trash t)


;;; VC
(use-package magit
  :bind
  ("C-x g" . magit-status))


;;; TTY
(use-package mistty
  :bind (("C-c s" . mistty)
	     ("C-c 4 s" . mistty-other-window)))
