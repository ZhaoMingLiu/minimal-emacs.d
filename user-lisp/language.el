;;; language.el --- Language -*- no-byte-compile: t; lexical-binding: t; -*-

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))


(use-package eglot
  :ensure nil
  :commands (eglot-ensure
             eglot-rename
             eglot-format-buffer)
  :config
  (setq eglot-autoshutdown t
        eglot-sync-connect nil)
  :hook ((python-mode
	      python-ts-mode

	      lua-ts-mode

	      sh-mode
	      bash-ts-mode

          yaml-ts-mode) . eglot-ensure))


(add-hook 'python-ts-mode-hook #'display-fill-column-indicator-mode)


(use-package apheleia
  :ensure t
  :commands (apheleia-mode
             apheleia-global-mode)
  :hook ((prog-mode
          yaml-ts-mode) . apheleia-mode))


(provide 'language)
