(setq inhibit-startup-message t)

(defun add-hook-m (fun &rest hooks)
  (dolist (hook hooks)
    (add-hook fun hook)))

(add-hook-m 'display-line-numbers-mode
	    'prog-mode-hook 'org-mode-hook)

(load-theme 'srcery t)
(ivy-mode)
