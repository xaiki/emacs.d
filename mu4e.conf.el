(require 'xa-email)
(require 'mu4e-hacks)
(setq mu4e-mu-binary "~/.local/bin/mu")
(setq mu4e-maildir-shortcuts
         '( ("/.Gmail.INBOX"       . ?i)
            ("/.Gmail.Sent Mail"   . ?s)
            ("/.Gmail.Trash"       . ?t)
            ("/.Gmail.All Mail"    . ?a))
         mu4e-maildir "~/Mail"
         mu4e-get-mail-command "offlineimap -u basic"
         mu4e-user-mail-address-regexp "xaiki"
         mu4e-sent-folder "/.Gmail.Sent"
         mu4e-drafts-folder "/.Gmail.Drafts"
         mu4e-trash-folder "/.Trash"
         mu4e-headers-leave-behavior 'apply)

(setq mail-user-agent 'mu4e-user-agent)
(setq message-signature '(xa:random-signature))

;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(require 'org-mu4e)
(setq mu4e-attach-flag-mark ?⚓)
;;(require 'mu4e-gnus)
;(eval (string (eval (intern (concat "mu4e-" "default" "-mark")))))
