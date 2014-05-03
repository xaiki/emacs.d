(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(notmuch-saved-searches
   (quote
    (("inbox" . "tag:inbox")
     ("unread" . "tag:unread")
     ("Gmail.INBOX" . "folder:Gmail.INBOX")
     ("Opcode-ALL" . "folder:Gmail.xaiki@inaes.opcode"))))
 '(org-clock-persist-query-save t)
 '(org-clock-sound t)
 '(org-latex-pdf-process
   (quote
    ("latexmk -g -pdf %f" "pdftk %b.pdf output %b.crypt.pdf owner_pw `apg -n 1 +s`")))
 '(org-show-notification-handler (quote notifications-notify))
 '(safe-local-variable-values
   (quote
    ((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
           (add-hook
            (quote write-contents-functions)
            (lambda nil
              (delete-trailing-whitespace)
              nil))
           (require
            (quote whitespace))
           "Sometimes the mode needs to be toggled off and on."
           (whitespace-mode 0)
           (whitespace-mode 1))
     (whitespace-line-column . 80)
     (whitespace-style face trailing lines-tail)
     (require-final-newline . t)
     (encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-refine-added ((t (:inherit diff-refine-change :background "#007700"))))
 '(diff-refine-removed ((t (:inherit diff-refine-change :background "#770000"))))
 '(notmuch-message-summary-face ((t (:background "#111" :box (:line-width 1 :color "#222") :weight ultra-bold :height 1.2))))
 '(org-agenda-current-time ((t (:inherit org-time-grid :foreground "green" :weight bold))) t))
