;;; my-tty.el --- My Tty Config -*- no-byte-compile: t; lexical-binding: t; -*-

(use-package ghostel
  :ensure t
  :bind (("C-x m" . ghostel))
  :config
  (when (eq system-type 'windows-nt)
    (setq ghostel-shell '("pwsh"        ; better than powershell.exe
                          "-NoLogo"
                          "-ExecutionPolicy" "Bypass"))))

(use-package ghostel-eshell
  :ensure nil
  :hook (eshell-load . ghostel-eshell-visual-command-mode))

(use-package ghostel-compile
  :ensure nil
  :hook (elpaca-after-init . ghostel-compile-global-mode))

(use-package ghostel-comint
  :ensure nil
  :hook (elpaca-after-init . ghostel-comint-global-mode))


;; (use-package consult-ghostel
;;   :ensure nil
;;   :after (ghostel consult)
;;   :demand t
;;   ;; :hook (elpaca-after-init . consult-ghostel-mode)
;;   :bind (("C-x m" . consult-ghostel)
;;          :map project-prefix-map
;;          ("m" . consult-ghostel-project)
;;          :map ghostel-semi-char-mode-map
;;          ("C-c h" . consult-ghostel-history)))


(provide 'my-tty)
