;;; pre-early-init.el -- PRE-EARLY-INIT -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Frame Display
(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t)

(dolist (var '(default-frame-alist initial-frame-alist))
  ;; (add-to-list var '(width . (text-pixels . 1000)))
  ;; (add-to-list var '(height . (text-pixels . 820)))
  (add-to-list var '(alpha-background . 90))
  (add-to-list var '(fullscreen . maximized)))


;;; Minibuffer Hack
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (set-window-scroll-bars
             (minibuffer-window frame) 0 nil 0 nil t)
            (set-window-fringes
             (minibuffer-window frame) 8 8 5 t)))


;;; Prevent Flash
(set-face-attribute 'default nil :background "#000000" :foreground "#ffffff")
(set-face-attribute 'mode-line nil :background "#000000" :foreground "#ffffff" :box 'unspecified)


;;; Reducing clutter in ~/.emacs.d by redirecting files to ~/.emacs.d/var/
;; NOTE: This must be placed in 'pre-early-init.el'.
(setq user-emacs-directory (expand-file-name "var/" minimal-emacs-user-directory))
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))


;;; Display Startup Time
(defun display-startup-time ()
  "Display the startup time and number of garbage collections."
  (message "Emacs init loaded in %.2f seconds (Full emacs-startup: %.2fs) with %d garbage collections."
           (float-time (time-subtract after-init-time before-init-time))
           (time-to-seconds (time-since before-init-time))
           gcs-done))

(add-hook 'emacs-startup-hook #'display-startup-time 100)
