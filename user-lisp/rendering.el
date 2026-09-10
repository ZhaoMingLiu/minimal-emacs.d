;;; rendering.el --- Rendering -*- no-byte-compile: t; lexical-binding: t; -*-

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
  ;; :config
  ;; (load-theme 'modus-flexoki-light :no-confirm))
  )

(use-package auto-dark
  :init (auto-dark-mode)
  :custom
  (custom-safe-themes t)
  (auto-dark-themes '((modus-flexoki-dark) (modus-flexoki-light))))

;; Fonts
(use-package nerd-icons
  :config
  (unless (find-font (font-spec :name "Symbols Nerd Font Mono"))
    (nerd-icons-install-fonts (concat (getenv "USERPROFILE") "/Desktop/"))))

(set-face-attribute 'default nil :family "Zx Proto" :height 100 :weight 'normal)

(set-face-attribute 'font-lock-comment-face nil :font "Zx Proto::+ss01" :slant 'italic :underline nil)

(progn
  ;; set font for emoji (if before emacs 28, should come after setting symbols. emacs 28 now has 'emoji . before, emoji is part of 'symbol)
  (set-fontset-font
   t
   (if (version< emacs-version "28.1")
       '(#x1f300 . #x1fad0)
     'emoji
     )
   (cond
    ((member "Apple Color Emoji" (font-family-list)) "Apple Color Emoji")
    ((member "Noto Color Emoji" (font-family-list)) "Noto Color Emoji")
    ((member "Noto Emoji" (font-family-list)) "Noto Emoji")
    ((member "Segoe UI Emoji" (font-family-list)) "Segoe UI Emoji")
    ((member "Symbola" (font-family-list)) "Symbola"))))

;; Utils
(use-package rainbow-delimiters :hook prog-mode)

(use-package goggles :hook ((prog-mode text-mode) . goggles-mode))

(use-package crystal-point :hook (after-init . crystal-point-enable))

;; (use-package vim-tab-bar :hook after-init)

(use-package breadcrumb :hook emacs-startup)

;; (use-package moody
;;   :config
;;   (moody-replace-mode-line-front-space)
;;   (moody-replace-mode-line-buffer-identification)
;;   (moody-replace-vc-mode))


(provide 'rendering)
