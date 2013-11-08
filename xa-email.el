(require 'smtpmail)
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

(defun xa:email-addresses ()
  (let ((result))
    (dolist (style xa:posting-styles)
      (mapcar (lambda (x) (let ((addr (if (listp x) x nil)))
                            (when (member 'address x)
                              (setq result (append result (list (nth 1 addr))))))) style))
    (nreverse result)))

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
  (let ((mail-abbrev-mode-regexp
         "^From:"))
    (when (mail-abbrev-in-expansion-header-p)
      (xa:complete-from))))

(defun xa:complete-from ()
  "Complete text at START with a user name and email."
  (let ((end (point))
        (start (save-excursion
                 (re-search-backward "\\(\\`\\|[\n:,]\\)[ \t]*")
                 (goto-char (match-end 0))
                 (point)))
        choices)
    (dolist (email (xa:email-addresses))
      (add-to-list 'choices (concat "\"" user-full-name "\" <" email ">")))
    (list start end choices)))

(add-hook 'message-mode-hook
          (lambda ()
            (add-to-list 'completion-at-point-functions
                         'xa:message-complete-function)))

(provide 'xa-email)
