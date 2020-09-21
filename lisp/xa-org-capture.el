;;; xa-org-capture --- Org capture configuration
;;; Comentary:
;;;
;;; Org Capture mode replaces remember mode for capturing tasks and notes.
;;;
;;; To add new tasks efficiently I use a minimal number of capture
;;; templates. I used to have lots of capture templates, one for each
;;; org-file. I'd start org-capture with C-c c and then pick a template that
;;; filed the task under * Tasks in the appropriate file.
;;; 
;;; I found I still needed to refile these capture tasks again to the
;;; correct location within the org-file so all of these different capture
;;; templates weren't really helping at all. Since then I've changed my
;;; workflow to use a minimal number of capture templates – I create the new
;;; task quickly and refile it once. This also saves me from maintaining my
;;; org-capture templates when I add a new org file.
;;;
;;; Code:
;;; http://doc.norang.ca/org-mode.html#Capture 

(require 'xa-org-diary)
(setq org-default-notes-file (concat org-directory "/" "refile.org"))

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file org-default-notes-file)
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file org-default-notes-file)
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file org-default-notes-file)
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree org-default-diary-file)
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file org-default-notes-file)
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file org-default-notes-file)
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file org-default-notes-file)
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file org-default-notes-file)
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))
(provide 'xa-org-capture)
;;; xa-org-capture.el ends here
