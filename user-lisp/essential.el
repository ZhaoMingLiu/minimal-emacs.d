;;; essential.el --- Essential -*- no-byte-compile: t; lexical-binding: t; -*-

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
  (setq undo-fu-allow-undo-in-region nil
	    undo-fu-ignore-keyboard-quit t))


(provide 'essential)
