(require 'xa-nm)
(require 'offlineimap)

(defun xa:async-smtpmail-send-it ()
  (async-start
   `(lambda ()
      (require 'smtpmail)
      (with-temp-buffer
        (insert ,(buffer-substring-no-properties (point-min) (point-max)))
        ;; Pass in the variable environment for smtpmail
        ,(async-inject-variables "\\`\\(smtpmail\\|\\(user-\\)?mail\\)-")
        (smtpmail-send-it)))
   ;; What to do when it finishes
   (lambda (result)
     (message "Async process done, result: %s" result)))
  )

(setq send-mail-function 'xa:async-smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "smtp.gmail.com"
      message-send-mail-function 'xa:async-smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "0xa1f00@gmail.com" nil))
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

(defun xa:on-connect ()
  (message "conneted")
  (offlineimap)
  (smtpmail-send-queued-mail)
  (setq smtpmail-queue-mail nil))

(defun xa:on-disconnect ()
  (message "disconneted")
  (condition-case ex
      (offlineimap-kill 9)
    ('error (message (format "Ignoring exception: %s" ex))))
  (setq smtpmail-queue-mail t))

(add-to-list 'nm-connected-hook 'xa:on-connect)
(add-to-list 'nm-disconnected-hook 'xa:on-disconnect)
(nm-enable)
