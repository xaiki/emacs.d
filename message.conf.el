(when
    (require 'xa-email nil t)
  (progn  
    (setq message-alternative-emails (xa:email-addresses-regexp))
    ;; When I reply, I don't want to have me in To or Cc
    (setq message-dont-reply-to-names (concat "\\("
					      (xa:email-addresses-regexp)
					      "\\|"
					      ;; Nor the Debian BTS
					      "^submit@bugs.debian\\.org$"
					      "\\)"))
    (setq message-confirm-send t)
    ;; Kill buffer when message is sent
    (setq message-kill-buffer-on-exit t)
    (setq message-elide-ellipsis "\n[…]\n\n")
    (setq message-citation-line-function 'message-insert-formatted-citation-line)
    (add-hook 'message-mode-hook 'footnote-mode)
    ;;(setq message-subscribed-address-functions '(gnus-find-subscribed-addresses))

    ;;(setq message-signature '(concat "Niv Sardi\n" (nth (random (length xa:message-signatures)) xa:message-signatures)))

    (setq message-send-mail-function 'message-smtpmail-send-it)


    ))
