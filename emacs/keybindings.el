;; ----------------------------------------------------------------------------
;; "THE BEER-WARE LICENSE" (Revision 42):
;; <gustek@riseup.net> wrote this file.  As long as you retain this notice you
;; can do whatever you want with this stuff. If we meet some day, and you think
;; this stuff is worth it, you can buy me a beer in return.
;; ----------------------------------------------------------------------------
(global-set-key (kbd "C-=") 'indent-whole-buffer)

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(global-set-key (kbd "C-c b") 'insert-beerware)
(global-set-key (kbd "C-c g") 'insert-gpl)
(global-set-key (kbd "M-p") 'zap-up-to-char)
