;;; my-tty.el --- My Tty Config -*- no-byte-compile: t; lexical-binding: t; -*-

(use-package ghostel
  :ensure t
  :bind (("C-x m" . ghostel)
         :map ghostel-mode-map
         ("C-c l" . ghostel-clear-scrollback))
  :config
  (setq ghostel-shell '("powershell.exe")))

(use-package ghostel-eshell
  :ensure nil
  :hook (eshell-load . ghostel-eshell-visual-command-mode))

(use-package ghostel-compile
  :ensure nil
  :hook (after-init . ghostel-compile-global-mode))

(use-package ghostel-comint
  :ensure nil
  :hook (after-init . ghostel-comint-global-mode))


(provide 'my-tty)
