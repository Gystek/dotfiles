(in-package :stumpwm)

(defparameter *modules-path*
  (directory-namestring (truename (merge-pathnames (user-homedir-pathname) ".stumpwm.d")))
  "The directory containing the configuration modules.")

(export '*modules-path*)

(defun load-module (module)
  "Load (or reload) a configuration module."
  (let ((file (merge-pathnames (string-downcase
				(format nil "~a.lisp" module))
			       *modules-path*)))
    (and (probe-file file) (load file))))

(defmacro bind-key (key value)
  `(define-key *root-map* (kbd ,key) ,value))

(set-fg-color "#eceff4")
(set-bg-color "#2e3440")
(set-border-color "#22272e")
(set-font "unifont")
(setq *message-window-gravity*
      (setq *message-window-input-gravity*
	    (setq *input-window-gravity*
		  :top)))
(setq *timeout-wait* 10)

(load-module "keys")
(load-module "sound")
(load-module "modeline")
(load-module "screen")
