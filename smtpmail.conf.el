(require 'xa-nm)

(setq send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "smtp.gmail.com"
      message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "0xa1f00@gmail.com" nil))
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

(defun xa:on-connect ()
  (message "disconneted")
  (smtpmail-send-queued-mail)
  (setq smtpmail-queue-mail nil))

(defun xa:on-disconnect ()
  (message "disconneted")
  (setq smtpmail-queue-mail t))

(add-to-list 'nm-connected-hook 'xa:on-connect)
(add-to-list 'nm-disconnected-hook 'xa:on-disconnect)
(nm-enable)
