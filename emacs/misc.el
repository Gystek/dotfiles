(setq backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)

(setq vc-make-backup-files t)

(add-hook 'c-mode-hook 'auto-revert-mode)
(setq c-default-style "linux")

(setq user-full-name "Gustek")
(setq user-mail-address "gustek@riseup.net")
