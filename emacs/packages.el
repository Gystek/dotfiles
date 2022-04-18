(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(eval-when-compile
  (require 'use-package))

(use-package company :ensure t)

(use-package srcery-theme
  :ensure t
  :config (load-theme 'srcery t))

(use-package ivy :ensure t)

(use-package nix-modeline :ensure t)
(use-package nix-mode :ensure t)

(use-package paradox :ensure t)

(use-package magit :ensure t)
