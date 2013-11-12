(require 'xa-email)
(require 'mu4e-accounts)

(mu4e-maildirs-extension)
(setq mu4e-mu-binary "~/.local/bin/mu")
(setq mu4e-maildir-shortcuts
         '( ("/.Gmail.INBOX"       . ?i)
            ("/.Gmail.Sent"        . ?s)
            ("/.Gmail.Trash"       . ?t)
            ("/.Gmail.All Mail"    . ?a)
            ("/.Gmail.xaiki@inaes.opcode" . ?o)
            ("/.UNQ.INBOX"         . ?u))
         mu4e-bookmarks
         '(("maildir:/.Gmail.INBOX OR maildir:/.UNQ.INBOX OR maildir:/.Gmail.Sent OR maildir:/.UNQ.Sent" "All mail you care about" ?m)
           ("maildir:/.Gmail.INBOX OR maildir:/.Gmail.Sent" "Gmail" ?g)
           ("maildir:/.UNQ.INBOX OR maildir:/.UNQ.Sent" "UNQ" ?u)
           ("flag:unread AND NOT flag:trashed" "Unread messages" ?U)
           ("date:today..now" "Today's messages" ?t)
           ("date:7d..now" "Last 7 days" ?w))
         mu4e-headers-fields
         '( (:human-date    .   12)
            (:flags         .    6)
            (:from-or-to    .   22)
            (:subject       .   nil))
         mu4e-maildir "~/Mail"
         mu4e-get-mail-command "echo hacked"
         mu4e-user-mail-address-regexp "xaiki"
         mu4e-user-mail-address-list '("xaiki@debian.org"
                                       "xaiki@inaes.gob.ar"
                                       "niv.sardi@unq.edu.ar"
                                       "0xa1f00@gmail.com"
                                       "xaiki@evilgiggle.com"
                                       )
         mu4e-sent-folder "/.Gmail.Sent"
         mu4e-drafts-folder "/.Gmail.Drafts"
         mu4e-trash-folder "/.Trash"
         mu4e-headers-leave-behavior 'apply
         mu4e-use-fancy-chars t
         mu4e-html2text-command "w3m -dump -T text/html -s -graph"
         mail-user-agent 'mu4e-user-agent
         message-signature '(xa:random-signature)
         mu4e-compose-signature '(xa:random-signature)
         mu4e-view-show-images t)

(setq  mu4e-headers-new-mark       (purecopy '("N" . "☐")))
(setq  mu4e-headers-unread-mark    (purecopy '("u" . "⭑")))

(setq offlineimap-enable-mode-line-p '(string-match "mu4e-.*-mode"
                                                    major-mode))

(setq message-kill-buffer-on-exit t)

(add-hook 'mu4e-compose-mode-hook
          (defun xa:mu4e-compose-hook ()
            "My settings for message composition."
            (set-fill-column 72)
            (flyspell-mode)))


;; enable inline images
(setq mu4e-view-show-images t)
;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(require 'org-mu4e)
(setq mu4e-attach-flag-mark ?⚓)
;;(require 'mu4e-gnus)
;(eval (string (eval (intern (concat "mu4e-" "default" "-mark")))))
