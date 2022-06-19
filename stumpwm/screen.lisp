(defun xrandr-command (multi)
  (format nil
	  "xrandr --output eDP-1 --primary --mode 1920x1080 --pos ~a --rotate normal --output HDMI-1 ~a"
	  (if multi
	      "1680x0"
	    "0x0")
	  (if multi
	      "--mode 1680x1050 --pos 0x0 --rotate normal"
	    "--off")))

(defparameter *multi-screen* nil)

(defcommand toggle-screen-layout () ()
  (setq *multi-screen* (not *multi-screen*))
  (run-shell-command (xrandr-command *multi-screen*)))

(bind-key "C-S" "toggle-screen-layout")

(run-shell-command "redshift -l 45.76:4.83")
