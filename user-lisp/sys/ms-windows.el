;;; ms-windows.el --- MS-Windows Build Config -*- no-byte-compile: t; lexical-binding: t; -*-

;; Essential for Windows
(let ((user-home (or (getenv "USERPROFILE") (getenv "HOME"))))
  (when user-home
    (setq default-directory (file-name-as-directory (expand-file-name user-home)))))

(let ((paths (list "C:/msys64/ucrt64/bin" ; coreutil, gcc and make
                   "C:/msys64/usr/bin"
                   "C:/nvm4w/nodejs"
                   "C:/Program Files/LLVM/bin" ; Clang
                   (expand-file-name "AppData/Local/Microsoft/WinGet/Links" (getenv "USERPROFILE"))  ; WinGet
                   (expand-file-name ".bun/bin" (getenv "USERPROFILE"))))) ; Bun
  (dolist (path paths)
    (when (and path (file-directory-p path))
      (add-to-list 'exec-path path)
      (setenv "PATH" (concat path ";" (getenv "PATH"))))))


;; Fix gpg error with gpg4win
(use-package epg-config
  :ensure nil
  :custom
  (epg-gpg-program "C:/Program Files/GnuPG/bin/gpg.exe") ; force using GPG4Win
  (epg-pinentry-mode 'loopback))

(use-package package
  :ensure nil
  :config
  (setq package-gnupghome-dir
        (let ((gpg-dir (expand-file-name "elpa/gnupg" user-emacs-directory)))
          (if (eq system-type 'windows-nt)
              (concat "/" (downcase (substring gpg-dir 0 1)) (substring gpg-dir 2))
            gpg-dir))
        )) ; Get Clean Path for GPG4Win


;; make left alt great again
(setq w32-recognize-altgr nil)


(provide 'ms-windows)
