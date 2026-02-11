;; Emacs is not MS Word
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq inhibit-startup-message t)

;; Save backup files elsewhere
(setq backup-directory-alist
      `(("." . ,(expand-file-name (concat user-emacs-directory "backups")))))

(setq vc-make-backup-files t)

;; Utility functions

(defmacro multi-bind (map &rest bindings)
  (dolist (binding bindings)
    `(define-key ,map ,(car binding) ',(cdr binding))))

;; Package management
(condition-case nil
    (require 'use-package)
  (file-error
   (require 'package)
   (add-to-list 'package-archives
		'("melpa" . "https://melpa.org/packages/") t)
   (package-initialize)
   (package-refresh-contents)
   (package-install 'use-package)
   (setq use-package-always-ensure t)
   (require 'use-package)))

(use-package magit)

(use-package eglot
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'eglot-ensure)
  :config
  (setq-default eglot-workspace-configuration
		'(:haskell (:plugin (:stan (:globalOn :json-false))
				    :formattingProvider "fourmolu")))
  :custom
  (eglot-autoshutdown t)
  (eglot-confirm-server-initiated-edits nil))

(use-package rustic
  :init
  (multi-bind rustic-mode-map
	      ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status)))

(use-package lsp-mode
  :hook (lsp-mode . lsp-enable-which-key-integration))
(use-package lsp-ui)

(setq lsp-rust-analyzer-cargo-watch-command "clippy")
(setq lsp-eldoc-render-all t)
(setq lsp-idle-delay 0.6)
(setq lsp-inlay-hint-enable t)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(setq lsp-ui-peek-always-show t)
(setq lsp-ui-sideline-show-hover t)
(setq lsp-ui-doc-enable nil)

(use-package treemacs)
(use-package lsp-treemacs)
(use-package treemacs-projectile)

(use-package projectile)

(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(use-package ivy)
(ivy-mode)
(setq enable-recursive-minibuffers t)

(use-package which-key)
(which-key-mode)

(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

(use-package geiser-mit)

(use-package haskell-mode)
(use-package lsp-haskell)

(use-package haskell-mode
  :hook (haskell-mode . lsp)
  :hook (haskell-literate-mode . lsp))

(use-package slime :ensure t
  :config
  (setq inferior-lisp-program "sbcl"
	slime-enable-evaluate-in-emacs t
	slime-net-coding-system 'utf-8-unix))

(defun restart-slime ()
  (interactive)
  (cl-flet ((slime-buf ()
	    	       (get-buffer (format "*slime-repl ~A*" (file-name-nondirectory inferior-lisp-program))))
	    (get-current-buf (slime-buf)
			     (when (and slime-buf
					(eq slime-buf
					    (current-buffer))
					(> (count-windows) 1))
			       (other-window 1))
			     (current-buffer)))
    (let* ((inferior-lisp-buf (get-buffer "*inferior-lisp*"))
	   (slime-buf (slime-buf))
	   (current-buf (get-current-buf slime-buf)))
      (if (and inferior-lisp-buf
	       slime-buf)
	  (slime-restart-inferior-lisp)
	(progn
	  (slime)
	  (switch-to-buffer current-buf)))
      (setq slime-buf (slime-buf))
      (delete-other-windows)
      (split-window-horizontally)
      (select-window (frame-first-window))
      (switch-to-buffer current-buf)
      (other-window 1)
      (switch-to-buffer slime-buffer))))

(when (require 'slime "slime" t)
  (slime-setup '(slime-fancy slime-asdf slime-references slime-indentation)))


;; Line numbering and modeline stuff
(setq display-line-numbers-type 'relative)
(add-hook 'after-init-hook 'global-display-line-numbers-mode)

(setq column-number-mode t)

;; Buffer refresh
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; Shell stuff
(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map
              (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

;; Latex and PDF files
(defun zathura-open-file (path)
  (interactive "f")
  (start-process "zathura" nil "zathura" path))

(defvar latex-compiler "tectonic")
(defun latex-compile ()
  (interactive)
  (start-process "latex-compile" "*LaTeX compilation*"
		 latex-compiler (buffer-file-name)))

(keymap-global-set "C-c c" 'latex-compile)

(defun meow-setup ()
  (meow-define-keys 'motion
   '("e" . meow-next)
   '("o" . meow-prev)
   '("<escape>" . ignore))
  (meow-define-keys 'leader
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-define-keys 'insert
    '("C-[" . meow-normal-mode))
  (meow-define-keys 'normal
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '("'" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("h" . meow-delete)
   '("H" . meow-backward-delete)
   '("w" . meow-next-word)
   '("W" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("n" . meow-left)
   '("N" . meow-left-expand)
   '("u" . meow-insert)
   '("U" . meow-open-above)
   '("e" . meow-next)
   '("E" . meow-next-expand)
   '("o" . meow-prev)
   '("O" . meow-prev-expand)
   '("i" . meow-right)
   '("I" . meow-right-expand)
   '("m" . meow-join)
   '("k" . meow-search)
   '("p" . meow-block)
   '("P" . meow-to-block)
   '(";" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("f" . meow-undo)
   '("F" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("d" . meow-mark-word)
   '("D" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("j" . meow-save)
   '("J" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("\"" . repeat)
   '("<escape>" . ignore)))
(use-package meow
  :config
  (require 'meow)
  (setq meow-cheatsheet-physical-layout meow-cheatsheet-physical-layout-ansi)
  (meow-setup)
  (meow-global-mode 1))

;; Org-mode

(setq org-agenda-files
      (cons "~/todo.org"
	    (directory-files-recursively "~/Documents/knowledge/" "\\.org$")))

(setq org-latex-pdf-process
      '("tectonic -X compile --outdir=%o -Z shell-escape -Z continue-on-errors %f"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company geiser-mit haskell-mode ivy lsp-haskell lsp-treemacs lsp-ui
	     magit meow projectile rustic slime treemacs-projectile
	     treemacs-tab-bar)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
