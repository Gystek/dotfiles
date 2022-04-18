(defparameter *audio-sink* 0)
(defparameter *audio-cmd*  "pactl -- set-sink-volume")

(defparameter *muted* nil)
(defparameter *previous-vol* 0)
(defparameter *volume* 0)

(defun set-volume (v)
  "Set the system audio volume."
  (run-shell-command (format nil "~a ~a ~a%" *audio-cmd* *audio-sink* v))
  (setf *volume* v))

(defcommand update-volume (value)
  ((:number "New-volume"))
  (if *muted*
      (setf *muted* nil))
  (set-volume value))

(defcommand mute-sound () ()
  (if *muted*
      (progn
	(set-volume *previous-vol*)
	(setf '*muted* nil))
    (progn
      (setf '*previous-vol* *volume*)
      (set-volume 0)
      (setf '*muted* t))))

(bind-key "C-i" (format nil "update-volume ~a" (+ *volume* 10))) ; might want to fix that cuz' it decreases instead of increasing...
(bind-key "C-d" (format nil "update-volume ~a" (- *volume* 10)))
(bind-key "M"   "mute-sound")
