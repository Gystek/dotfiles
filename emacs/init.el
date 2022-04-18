(defvar my-modules '("packages" "misc" "interface" "keybindings" "commands"))

(dolist (module my-modules)
  (load (expand-file-name (format "%s.el" (concat user-emacs-directory module)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit paradox nix-mode nix-modeline ivy srcery-theme company use-package))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
