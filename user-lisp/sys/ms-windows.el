;;; ms-windows.el --- MS-Windows Build Config -*- no-byte-compile: t; lexical-binding: t; -*-

;; Essential for Windows
(let ((user-home (or (getenv "USERPROFILE") (getenv "HOME"))))
  (when user-home
    (setq default-directory (file-name-as-directory (expand-file-name user-home)))))

(let ((paths (list "C:/msys64/ucrt64/bin" ; coreutil, gcc and make
                   "C:/msys64/usr/bin"
                   "C:/Program Files/LLVM/bin" ; Clang
                   (expand-file-name "AppData/Local/Microsoft/WinGet/Links" (getenv "USERPROFILE"))  ; WinGet
                   (expand-file-name ".bun/bin" (getenv "USERPROFILE"))))) ; Bun
  (dolist (path paths)
    (when (and path (file-directory-p path))
      (add-to-list 'exec-path path)
      (setenv "PATH" (concat path ";" (getenv "PATH"))))))

;; make left alt great again
(setq w32-recognize-altgr nil)


(provide 'ms-windows)
