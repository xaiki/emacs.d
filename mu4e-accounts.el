(setq xa:mu4e-account-alist
      '(("*"
         (mu4e-sent-folder "/.Gmail.Sent")
         (mu4e-drafts-folder "/.Gmail.Drafts")
         (user-mail-address "xaiki@evilgiggle.com")
         (smtpmail-default-smtp-server "smtp.gmail.com")
         (smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))
         (smtpmail-auth-credentials '(("smtp.gmail.com" 587 "0xa1f00@gmail.com" nil)))
         (smtpmail-smtp-server "smtp.gmail.com")
         (smtpmail-smtp-service 587)
         (mu4e-compose-signature '(xa:random-signature)))
        ("Gmail"
         (user-mail-address "xaiki@evilgiggle.com")
         )
        ("debian"
         (user-mail-address "xaiki@debian.org"))
        ("inaes"
         (user-mail-address "xaiki@inaes.gob.ar")
         (mu4e-compose-signature "Niv Sardi
Responsable de la Comisión de Cooperativas Tecnologicas
Instituto Nacional de Asociativismo y Economía Social"))
        ("UNQ"
         (mu4e-sent-folder "/.UNQ.Sent")
         (mu4e-drafts-folder "/.UNQ.Drafts")
         (user-mail-address "niv.sardi@unq.edu.ar")
         (smtpmail-default-smtp-server "smtp.correo.unq.edu.ar")
         (smtpmail-starttls-credentials '(("smtp.correo.unq.edu.ar" 465 nil nil)))
         (smtpmail-auth-credentials '(("smtp.correo.unq.edu.ar" 465 "niv.sardi@correo.unq.edu.ar" nil)))
         (smtpmail-smtp-server "smtp.correo.unq.edu.ar")
         (smtpmail-smtp-service 465)
         (mu4e-compose-signature "Niv Sardi
Asesor, Programa de Televisión Digital")
         )))

(defun xa:filter (condp lst)
    (delq nil
          (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

(defun xa:apply-vars (vars)
  (mapc #'(lambda (var)
            (set (car var) (cadr var)))
        vars))

(defun xa:mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((user-mail nil)
         (account-vars
          (if mu4e-compose-parent-message
              (let ((ret nil))
                (dolist (to (mapcar 'cdr (mu4e-message-field mu4e-compose-parent-message :to)))
                  (when (and (not ret) (member to mu4e-user-mail-address-list))
                      (setq ret (xa:filter (lambda (x) (equal to (cadr (assoc 'user-mail-address x)))) xa:mu4e-account-alist))
                      (setq user-mail to))
                  )
                (unless ret
                  (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                    (xa:filter (lambda (x) (string-match (car x) maildir)) xa:mu4e-account-alist)
                    ))
                (cdar ret))
            (let ((account (ido-completing-read "Compose with account: "
                             (mapcar #'(lambda (var) (car var)) xa:mu4e-account-alist)
                             nil t nil nil (caar xa:mu4e-account-alist))))
              (cdr (assoc account xa:mu4e-account-alist))))))
    account-vars

    (xa:apply-vars (cdr (member "*" (car xa:mu4e-account-alist))))
    (if account-vars
        (xa:apply-vars account-vars)
      (warn (concat "No email account found: " account-vars)))
    (if user-mail
        (setq user-mail-address user-mail)
      )))

(add-hook 'mu4e-compose-pre-hook 'xa:mu4e-set-account)

(provide 'mu4e-accounts)
