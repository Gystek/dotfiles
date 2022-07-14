;; Email Setup

(setq user-mail-address "gustek@riseup.net"
      user-full-name    "Gustek")

(load-library "smtpmail")
(load-library "nnimap")
(load-library "starttls")
(require 'nnir)

(setq gnus-select-method
      '(nnimap "mail.riseup.net"
	       (nnimap-address "mail.riseup.net")
	       (nnimap-server-port 993)
	       (nnimap-authinfo-file "~/.authinfo")
	       (nnimap-stream ssl)))

(setq smtpmail-starttls-credentials '(("mail.riseup.net" 587 nil nil))
      smtpmail-smtp-server          "mail.riseup.net"
      smtpmail-default-smtp-server  "mail.riseup.net"
      send-mail-function            'smtpmail-send-it
      message-send-mail-function    'smtpmail-send-it
      smtpmail-smtp-service         587)

(add-hook 'gnus-topic-mode-hook 'gnus-topic-mode)

(setq gnus-ignored-newgroups  ""
      gnus-summary-mark-below 0)

;; Synchronize sent mail with server
(setq gnus-parameters             '((".*" (gcc-self . "Sent")))
      gnus-outgoing-message-group "Sent")
