(require 'mu4e)
(setq xa:mu4e-account-alist
      '(("*"
         (mu4e-sent-folder "/Sent")
         (mu4e-drafts-folder "/Drafts")
         (user-mail-address "x@xaiki.net")
         (smtpmail-stream-type starttls)
         (smtpmail-default-smtp-server "smail.xaiki.net")
         (smtpmail-starttls-credentials '(("smail.xaiki.net" 25 nil nil)))
         (smtpmail-auth-credentials '(("evilgiggle.com" 25 "xaiki" nil)))
         (smtpmail-smtp-server "smail.xaiki.net")
         (smtpmail-smtp-service 25)
         (mu4e-compose-signature '(xa:random-signature))
         (ispell-dictionary "english"))
        ("Gmail"
         (user-mail-address "xaiki@evilgiggle.com")
         (mu4e-compose-signature '(xa:random-signature))
         )
        ("debian"
         (user-mail-address "xaiki@debian.org"))
        ("inaes"
         (user-mail-address "xaiki@inaes.gob.ar")
         (mu4e-compose-signature "Niv Sardi
Responsable de la Comisión de Cooperativas Tecnologicas
Instituto Nacional de Asociativismo y Economía Social")
         (ispell-dictionary "castellano8"))
        ("UNQ"
         (mu4e-sent-folder "/Sent")
         (mu4e-drafts-folder "/Drafts")
         (user-mail-address "niv.sardi@unq.edu.ar")
         (smtpmail-stream-type ssl)
         (smtpmail-default-smtp-server "smtp.correo.unq.edu.ar")
         (smtpmail-starttls-credentials '(("smtp.correo.unq.edu.ar" 465 nil nil)))
         (smtpmail-auth-credentials '(("smtp.correo.unq.edu.ar" 465 "niv.sardi@correo.unq.edu.ar" nil)))
         (smtpmail-smtp-server "smtp.correo.unq.edu.ar")
         (smtpmail-smtp-service 465)
         (mu4e-compose-signature "Niv Sardi
Asesor, Programa de Televisión Digital")
         (ispell-dictionary "castellano8"))
        ("Popcorn"
         (mu4e-sent-folder "/Sent")
         (mu4e-drafts-folder "/Drafts")
         (user-mail-address "xaiki@popcorntime.io")
         (mu4e-compose-signature "xaiki")
         (ispell-dictionary "english"))
        ("popcorn-press"
         (mu4e-sent-folder "/Sent")
         (mu4e-drafts-folder "/Drafts")
         (user-mail-address "press@popcorntime.io")
         (mu4e-compose-signature "xaiki")
         (ispell-dictionary "english"))
        ("popcorn-sponsors"
         (mu4e-sent-folder "/Sent")
         (mu4e-drafts-folder "/Drafts")
         (user-mail-address "sponsors@popcorntime.io")
         (mu4e-compose-signature "xaiki")
         (ispell-dictionary "english"))
        ("popcorn-hello"
         (mu4e-sent-folder "/Sent")
         (mu4e-drafts-folder "/Drafts")
         (user-mail-address "hello@popcorntime.io")
         (mu4e-compose-signature "xaiki")
         (ispell-dictionary "english"))
        ))

(defun xa:apply-vars (vars)
  (mapc #'(lambda (var)
            (set (car var) (cadr var)))
        vars))

(defun xa:mu4e-account-get-vars (account)
  "get vars for an account string"
  (delq nil
        (mapcar (lambda (x) (member account x))
                xa:mu4e-account-alist)))

(defun xa:mu4e-apply-account (account)
  "apply vars from account string"
  (xa:apply-vars
   (cdar (xa:mu4e-account-get-vars account))))

(defun xa:filter (condp lst)
    (delq nil
          (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(defun xa:mu4e-get-account-vars ()
  (if mu4e-compose-parent-message
      (let ((ret nil))
        (dolist (to (mapcar 'cdr
                            (append
                             (mu4e-message-field mu4e-compose-parent-message :to)
                             (mu4e-message-field mu4e-compose-parent-message :from))))
          (when (and (not ret)
                     ;;(member to mu4e-user-mail-address-list)
                     )
            (setq ret (xa:filter
                       (lambda (x)
                         (equal to (cadr (assoc 'user-mail-address x))))
                       xa:mu4e-account-alist))))
        (unless ret
          (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
            (xa:filter (lambda (x) (string-match (car x) maildir)) xa:mu4e-account-alist)
            ))
        (cdar ret))
    (let ((account (ido-completing-read "Compose with account: "
                                        (mapcar #'(lambda (var) (car var)) xa:mu4e-account-alist)
                                        nil t nil nil (caar xa:mu4e-account-alist))))
      (cdr (assoc account xa:mu4e-account-alist)))))

(defun xa:mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((user-mail nil)
         (account-vars (xa:mu4e-get-account-vars)))
    (message mu4e~headers-last-query)
    (xa:mu4e-apply-account "*")
    (if account-vars
        (xa:apply-vars account-vars)
      (warn (concat "No email account found: " account-vars)))))

(add-hook 'mu4e-compose-pre-hook 'xa:mu4e-set-account)
(add-hook 'message-setup-hook 'xa:mu4e-set-account)

(provide 'mu4e-accounts)
