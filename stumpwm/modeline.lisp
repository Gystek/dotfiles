(in-package :stumpwm)

(defparameter *last-battery* 15)

(defun gen-battery (level)
  (cond
   ((> level 50) "o///")
   ((> level 25) "o.//")
   ((> level 15) "o../")
   (t (progn
	(unless (= level *last-battery*)
	  (setq *last-battery* level)
	  (run-shell-command (format nil "notify-send -u critical 'Recharge battery: ~D% left' -t 30000" level) nil))
	"o..."))))

;; (defun gen-hp (level)
;;   (cond
;;    ((> level 75) "o)))")
;;    ((> level 50) "o))")
;;    ((> level 25) "o)")
;;    ((> level 0) "o")
;;    (else "ox")))

(defun battery ()
  (let ((level (parse-integer (run-shell-command
			       "acpi | grep 'Battery 0' | awk -F',' '{ print $2 }' | egrep -o '[0-9]+'" t))))
    (values level (gen-battery level))))

;; (defun sound ()
;;   (let* ((sink (string-trim '(#\Return #\Newline #\Linefeed)
;; 			    (run-shell-command "pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1"
;; 					       t)))
;; 	 (volume (string-trim '(#\Return #\Newline #\Linefeed)
;; 			      (run-shell-command (format nil
;; 							 "pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( ~a + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'" sink)
;; 						 t)))
;; 	 (values volume (format nil "~D o)))" volume)))))

(defun windows (w)
  (let* ((current (window-number w)))
    (format nil
	    "~{~a ~} | ~a"
	    (loop for i from 0 to 9
		  collect (format nil (if (= current i) "(~a)" "~a") i))
	    (window-title w))))

(defun date ()
  (string-trim '(#\Return #\Newline #\Linefeed)
	       (run-shell-command "date +'%a %d %b - %H:%M'" t)))

(defun mid-space (part0 part1)
  (make-string (+ 20 (- (/ (head-width (current-head)) 10)
			(+ (length part0)
			   (length part1))))
	       :initial-element #\Space))

(defun render-mode-line ()
  (multiple-value-bind (blevel bbar) (battery)
					;		       (multiple-value-bind (slevel sbar) (sound)
		       (let* ((part0 (windows (current-window)))
			      (part1 (format nil
					     "~a | ~a ~D%"
					     (date)
					;							  sbar slevel
					     bbar blevel)))
			 
			 (format nil
				 "~a~a~a"
				 part0
				 (mid-space part0 part1)
				 part1))));)

(setf *mode-line-background-color* "#DDDDDD")
(setf *mode-line-foreground-color* "#000000")
(setf *mode-line-position* :top)
(setf *mode-line-timeout* 5)
(enable-mode-line (current-screen) (current-head) t)
(setf *screen-mode-line-format* (list '(:eval (render-mode-line))))
