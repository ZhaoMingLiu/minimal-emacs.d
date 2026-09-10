;;; my-minibuffer.el --- My Minibuffer Config -*- no-byte-compile: t; lexical-binding: t; -*-

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


(provide 'my-minibuffer)
