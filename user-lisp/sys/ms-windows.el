;;; ms-windows.el --- MS-Windows Build Config -*- no-byte-compile: t; lexical-binding: t; -*-

;; Essential for Windows
(when (eq system-type 'windows-nt)
  (let ((user-home (or (getenv "USERPROFILE") (getenv "HOME"))))
    (when user-home
      (setq default-directory (file-name-as-directory (expand-file-name user-home)))
      ;; (cd default-directory)
      ))

  (let ((msys-ucrt-bin "C:/msys64/ucrt64/bin")
        (msys-usr-bin  "C:/msys64/usr/bin"))
    (add-to-list 'exec-path msys-ucrt-bin)
    (add-to-list 'exec-path msys-usr-bin)
    (setenv "PATH" (concat msys-ucrt-bin ";" msys-usr-bin ";" (getenv "PATH"))))

  ;; (add-to-list 'exec-path "C:/Program Files/LLVM/bin")
  ;; (setenv "PATH" (concat "C:/Program Files/LLVM/bin;" (getenv "PATH")))

  (add-to-list 'exec-path "C:/nvm4w/nodejs/")
  (setenv "PATH" (concat "C:/nvm4w/nodejs;" (getenv "PATH")))

  (let ((bun-bin-dir (expand-file-name ".bun/bin" (getenv "USERPROFILE"))))
    (when (file-directory-p bun-bin-dir)
      (add-to-list 'exec-path bun-bin-dir)
      (setenv "PATH" (concat bun-bin-dir ";" (getenv "PATH")))))


  (use-package epg-config
    :ensure nil
    :custom
    (epg-gpg-program "\"C:/Program Files/GnuPG/bin/gpg.exe\"") ; force using GPG4Win
    (epg-pinentry-mode 'loopback))

  (use-package package
    :ensure nil
    :config
    (setq package-gnupghome-dir
          (concat (get-file-buffer user-emacs-directory) "elpa/gnupg/"))) ; Get Clean Path for GPG4Win


  (setq w32-recognize-altgr nil))


(provide 'ms-windows)
