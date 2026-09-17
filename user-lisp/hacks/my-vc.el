;;; my-vc.el --- My VC Config -*- no-byte-compile: t; lexical-binding: t; -*-

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


(provide 'my-vc)
