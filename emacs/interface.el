(setq inhibit-startup-message t)

(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(setq column-number-mode t)
(global-linum-mode 1)

(load-theme 'srcery t)
(ivy-mode)
