(setq send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "0xa1f00@gmail.com" nil))
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)
