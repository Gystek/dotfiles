;; ----------------------------------------------------------------------------
;; "THE BEER-WARE LICENSE" (Revision 42):
;; <gustek@riseup.net> wrote this file.  As long as you retain this notice you
;; can do whatever you want with this stuff. If we meet some day, and you think
;; this stuff is worth it, you can buy me a beer in return.
;; ----------------------------------------------------------------------------
(defvar my-modules '("packages" "misc" "interface" "keybindings" "commands" "org" "slime"))

(dolist (module my-modules)
  (load (expand-file-name (format "%s.el" (concat user-emacs-directory module)))))

(setenv "PATH" (concat (getenv "PATH") ":/bin"))
(setq exec-path (append exec-path '("/bin")))

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lua-mode which-key use-package tuareg srcery-theme slime rust-mode projectile paradox nov nix-mode monokai-theme magit julia-mode ivy direnv company clang-format))
 '(smtpmail-smtp-server "mail.riseup.net")
 '(smtpmail-smtp-service 465))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
