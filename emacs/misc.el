;; ----------------------------------------------------------------------------
;; "THE BEER-WARE LICENSE" (Revision 42):
;; <gustek@riseup.net> wrote this file.  As long as you retain this notice you
;; can do whatever you want with this stuff. If we meet some day, and you think
;; this stuff is worth it, you can buy me a beer in return.
;; ----------------------------------------------------------------------------
(setq backup-directory-alist `(("." . ,(expand-file-name (concat user-emacs-directory "backups"))))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)

(setq vc-make-backup-files t)

(add-hook 'c-mode-hook 'auto-revert-mode)
(setq c-default-style "gnu")

(defun c-comment-setup ()
  (setq comment-start "/*"
	comment-end "*/"
	comment-multi-line t
	comment-padding nil
	comment-style 'extra-line
	comment-conntinue " * "
	comment-empty-lines t))
(add-hook 'c-mode-hook #'c-comment-setup)

(setq user-full-name "Gustek")
(setq user-mail-address "gustek@riseup.net")

(add-hook 'before-save-hook 'delete-trailing-whitespace)
