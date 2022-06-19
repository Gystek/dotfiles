;; ----------------------------------------------------------------------------
;; "THE BEER-WARE LICENSE" (Revision 42):
;; <gustek@riseup.net> wrote this file.  As long as you retain this notice you
;; can do whatever you want with this stuff. If we meet some day, and you think
;; this stuff is worth it, you can buy me a beer in return.
;; ----------------------------------------------------------------------------

;; I do not use M-x rmail or C-x m because I am too lazy to set them up
;; Seriously now, I just find it more convenient to use Mutt instead.

(defvar mutt-bin (format "/home/%s/.nix-profile/bin/mutt"
			(getenv "USER")))

(defun mutt ()
  (interactive)
  (split-window-horizontally)
  (other-window 1)
  (ansi-term mutt-bin "Mutt"))
