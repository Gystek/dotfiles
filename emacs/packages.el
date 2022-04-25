(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(eval-when-compile
  (require 'use-package))

(use-package company :ensure t
  :config (add-hook 'after-init-hook 'global-company-mode))

(use-package srcery-theme :ensure t)

(use-package ivy :ensure t)
(use-package projectile :ensure t
  :config (progn
	    (setq projectile-completion-system 'ivy)
	    (projectile-mode 1)
	    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)))

(use-package nix-modeline :ensure t)
(use-package nix-mode :ensure t)

(use-package paradox :ensure t)

(use-package magit :ensure t)

(use-package which-key :ensure t
  :config (which-key-mode 1))

(use-package direnv :config (direnv-mode) :ensure t)

(use-package pdf-tools
  :pin manual
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))
  :custom
  (pdf-annot-activate-created-annotations t))

(use-package julia-mode :ensure t)

(use-package rust-mode :ensure t
  :config
  (add-hook 'rust-mode-hook
	    (lambda () (setq indent-tabs-mode nil)))
  (setq rust-format-on-save t)
  (add-hook 'rust-mode-hook
	    (lambda () (prettify-symbols-mode)))
  (define-key rust-mode-map (kbd "C-c C-b") 'rust-check)
  (define-key rust-mode-map (kbd "C-c C-t") 'rust-test)
  (define-key rust-mode-map (kbd "C-c C-r") 'rust-run))

(use-package clang-format :ensure t
  :config
  (global-set-key (kbd "C-c C-f") (lambda () (interactive)
                                    (shell-command (format "cd %s; make format; cd -"
                                                           (projectile-project-root))))))
(use-package slime :ensure t
  :config (setq inferior-lisp-program "sbcl"))
