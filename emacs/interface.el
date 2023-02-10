;; ----------------------------------------------------------------------------
;; "THE BEER-WARE LICENSE" (Revision 42):
;; <gustek@riseup.net> wrote this file.  As long as you retain this notice you
;; can do whatever you want with this stuff. If we meet some day, and you think
;; this stuff is worth it, you can buy me a beer in return.
;; ----------------------------------------------------------------------------
(setq inhibit-startup-message t)

(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(setq column-number-mode t)
(global-linum-mode 1)

(set-face-attribute 'default nil :font "Pragmata Pro Mono-12")

(if window-system
    (load-theme 'srcery t)
  (load-theme 'monokai t))
(ivy-mode)
