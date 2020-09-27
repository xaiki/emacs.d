(require 'xa-nm)

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
      smtpmail-default-smtp-server "xaiki.net"
      message-send-mail-function 'xa:async-smtpmail-send-it
      smtpmail-starttls-credentials '(("xaiki.net" 587 nil nil))
      smtpmail-auth-credentials '(("xaiki.net" "imaps" "x@btn.sh" nil))
      smtpmail-smtp-server "xaiki.net"
      smtpmail-smtp-service 587)

(defun xa:mail-connect ()
  (message "smtpmail: conneted")
  (smtpmail-send-queued-mail)
  (setq smtpmail-queue-mail nil))

(defun xa:mail-disconnect ()
  (message "smtpmail: disconneted")
  (setq smtpmail-queue-mail t))

(add-to-list 'nm-connected-hook 'xa:mail-connect)
(add-to-list 'nm-disconnected-hook 'xa:mail-disconnect)
(nm-enable)

;;(setq smtpmail-auth-supported '(xoauth2 cram-md5 plain login))
(setq smtpmail-auth-supported '(cram-md5 plain login))
(setq smtpmail-xoauth-command "~/dotfiles/mail-scripts/oauth2-authinfo.py")

(defun xa:smtpmail-try-auth-method (process mech user password)
  (let (ret)
    (cond
     ((or (not mech)
	  (not user)
	  (not password))
      ;; No mechanism, or no credentials.
      mech)
     ((eq mech 'xoauth2)
      (smtpmail-command-or-throw
           process (concat "AUTH XOAUTH2 "
                           (shell-command-to-string
                            (concat smtpmail-xoauth-command
                                    " imap.gmail.com " user " imap")))
           235))
     ((eq mech 'cram-md5)
      (setq ret (smtpmail-command-or-throw process "AUTH CRAM-MD5"))
      (when (eq (car ret) 334)
	(let* ((challenge (substring (cadr ret) 4))
	       (decoded (base64-decode-string challenge))
	       (hash (rfc2104-hash 'md5 64 16 password decoded))
	       (response (concat user " " hash))
	       ;; Osamu Yamane <yamane@green.ocn.ne.jp>:
	       ;; SMTP auth fails because the SMTP server identifies
	       ;; only the first part of the string (delimited by
	       ;; new line characters) as a response from the
	       ;; client, and the rest as distinct commands.

	       ;; In my case, the response string is 80 characters
	       ;; long.  Without the no-line-break option for
	       ;; `base64-encode-string', only the first 76 characters
	       ;; are taken as a response to the server, and the
	       ;; authentication fails.
	       (encoded (base64-encode-string response t)))
	  (smtpmail-command-or-throw process encoded))))
     ((eq mech 'login)
      (smtpmail-command-or-throw process "AUTH LOGIN")
      (smtpmail-command-or-throw process (base64-encode-string user t))
      (smtpmail-command-or-throw process (base64-encode-string password t)))
     ((eq mech 'plain)
      ;; We used to send an empty initial request, and wait for an
      ;; empty response, and then send the password, but this
      ;; violate a SHOULD in RFC 2222 paragraph 5.1.  Note that this
      ;; is not sent if the server did not advertise AUTH PLAIN in
      ;; the EHLO response.  See RFC 2554 for more info.
      (smtpmail-command-or-throw
       process
       (concat "AUTH PLAIN "
	       (base64-encode-string (concat "\0" user "\0" password) t))
       235))
     (t
      (error "Mechanism %s not implemented" mech)))))

(setq smtpmail-debug-info t)
(setq smtpmail-debug-verb t)
