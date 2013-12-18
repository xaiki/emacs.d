(require 'mu4e)
(setq xa:mu4e-account-alist
      '(("*"
         (mu4e-sent-folder "/.Gmail.Sent")
         (mu4e-drafts-folder "/.Gmail.Drafts")
         (user-mail-address "xaiki@evilgiggle.com")
         (smtpmail-stream-type starttls)
         (smtpmail-default-smtp-server "smtp.gmail.com")
         (smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil)))
         (smtpmail-auth-credentials '(("smtp.gmail.com" 587 "0xa1f00@gmail.com" nil)))
         (smtpmail-smtp-server "smtp.gmail.com")
         (smtpmail-smtp-service 587)
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
         (mu4e-sent-folder "/.UNQ.Sent")
         (mu4e-drafts-folder "/.UNQ.Drafts")
         (user-mail-address "niv.sardi@unq.edu.ar")
         (smtpmail-stream-type ssl)
         (smtpmail-default-smtp-server "smtp.correo.unq.edu.ar")
         (smtpmail-starttls-credentials '(("smtp.correo.unq.edu.ar" 465 nil nil)))
         (smtpmail-auth-credentials '(("smtp.correo.unq.edu.ar" 465 "niv.sardi@correo.unq.edu.ar" nil)))
         (smtpmail-smtp-server "smtp.correo.unq.edu.ar")
         (smtpmail-smtp-service 465)
         (mu4e-compose-signature "Niv Sardi
Asesor, Programa de Televisión Digital")
         (ispell-dictionary "castellano8"))))

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
    (message mu4e~headers-last-query)
    (xa:mu4e-apply-account "*")
    (if account-vars
        (xa:apply-vars account-vars)
      (warn (concat "No email account found: " account-vars)))
    (if user-mail
        (setq user-mail-address user-mail)
      )))

(add-hook 'mu4e-compose-pre-hook 'xa:mu4e-set-account)

(provide 'mu4e-accounts)
