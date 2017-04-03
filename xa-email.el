(require 'smtpmail)
(require 'mu4e nil t)
(require 'mu4e-accounts nil t)
(setq
 user-mail-address "xaiki@evilgiggle.com"
 user-full-name  "Niv Sardi")

(defvar xa:message-signatures
  '("/*
 * Free Software hacker & hacktivist
 */"
    "# Free Software hacker & hacktivist"
    ";; Free Software hacker & hacktivist"
    "%% Free Software hacker & hacktivist")
  "Random signatures to pick.")

(defun xa:random-signature ()
  (concat "Niv Sardi\n" (nth (random (length xa:message-signatures)) xa:message-signatures)))

(defvar xa:posting-styles
      '((".*"
         (name "Niv Sardi")
         (address "xaiki@evilgiggle.com")
         (eval (ispell-change-dictionary "english"))
         (signature xa:random-signature))
        ((header "to" "croll")
         (address "xaiki@croll.fr"))
        ((header "to" "-es")
         (eval (ispell-change-dictionary "english")))
        ((header "to" "debian")
         (eval (ispell-change-dictionary "english"))
         (address "xaiki@debian.org")
         (organization "Debian")
         (signature xa:random-signature))
        ((header "to" "inaes")
         (address "xaiki@inaes.gob.ar")
         (organization "Instituto Nacional de Asociativismo y Economía Social")
         (signature "Responsable de la Comisión de Cooperativas Tecnológicas
Instituto Nacional de Asociativismo y Economia Social
Ministerio de Desarrollo Social")
         )))

(defvar xa:extend-email-regex  "\\([\\+-].+\\)?")

(defun xa:identities-email-addresses ()
  (let ((result))
    (dolist (style xa:posting-styles)
      (mapcar (lambda (x) (let ((addr (if (listp x) x nil)))
                            (when (member 'user-mail-address addr)
                              (setq result (append result (list (nth 1 addr))))))) style))
    (nreverse result)))

(defun xa:mu4e-email-addresses ()
  (let ((result))
    (dolist (style xa:mu4e-account-alist)
      (mapcar (lambda (x) (let ((addr (if (listp x) x nil)))
                            (when (member 'user-mail-address x)
                              (setq result (append result (list (nth 1 addr))))))) style))
    (nreverse result)))

(defun xa:email-addresses ()
  (delq nil (delete-dups (append (xa:identities-email-addresses) (xa:mu4e-email-addresses)))))

(xa:email-addresses)

(defun xa:email-addresses-regexp ()
  (concat "\\("
          (mapconcat 'identity (mapcar (lambda (email) (let ((ea (split-string email "@" t)))
                            (concat (car ea) xa:extend-email-regex "@"
                                    (mapconcat 'identity (cdr ea) ""))))
          (xa:email-addresses))
                     "\\|")
          "\\)"))

(defun xa:message-complete-function ()
  "Function used in `completion-at-point-functions' in `message-mode'."
  (cond
   ((let ((mail-abbrev-mode-regexp
           "^From:"))
      (mail-abbrev-in-expansion-header-p))
    (xa:complete-email (xa:candidates-from)))
   ((let ((mail-abbrev-mode-regexp
           "^To:"))
      (mail-abbrev-in-expansion-header-p))
    (xa:complete-email mu4e~contacts-for-completion))))

(defun xa:candidates-from ()
  (let ((choices))
    (dolist (email (xa:email-addresses))
      (add-to-list 'choices (concat "\"" user-full-name "\" <" email ">")))
    choices))

(defun xa:candidates-to ()
  (list mu4e~contains-line-matching)
  (let ((choices))
    (mu4e~request-contacts)
    (dolist (email (xa:email-addresses))
      (add-to-list 'choices (concat "\"" user-full-name "\" <" email ">")))
    choices))

(defun xa:complete-from ()
  (xa:complete-email (xa:candidates-from)))

(defun xa:header-extract ()
  (let* ((end (save-excursion
               (re-search-forward "\\(\\`\\|[\n:,]\\)[ \t]*")
               (goto-char (- (match-end 0) 1))
               (point)))
         (start (save-excursion
                 (re-search-backward "\\(\\`\\|[\n:,]\\)[ \t]*")
                 (goto-char (match-end 0))
                 (point))))
    (list start end)))

(defun xa:complete-email (choices)
  "Complete text at START with a user name and email."
  (append (xa:header-extract) (list choices)))


;; (add-hook 'message-mode-hook
;;           (lambda ()
;;             (add-to-list 'completion-at-point-functions
;;                          'xa:message-complete-function)))

(provide 'xa-email)
