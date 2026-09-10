;;; my-dired.el --- My Dired Config -*- no-byte-compile: t; lexical-binding: t; -*-

(use-package dired
  :ensure nil
  :defer t
  :custom
  (
   ;; ((insert-directory-program
   ;;   (when (eq system-type 'windows-nt) "ls.exe"))

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
  ;; :hook
  ;; (emacs-startup . dirvish-side)
  )


(use-package nerd-icons-dired :hook dired-mode)

(setq delete-by-moving-to-trash t)


(provide 'my-dired)
