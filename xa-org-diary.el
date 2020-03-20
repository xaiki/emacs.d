;;; xa-org-diary --- Org diary and agenda configuration
;;; Comentary:
;;;
;;; Refiling tasks is easy. After collecting a bunch of new tasks in my
;;; refile.org file using capture mode I need to move these to the correct
;;; org file and topic. All of my active org-files are in my
;;; org-agenda-files variable and contribute to the agenda. I collect
;;; capture tasks in refile.org for up to a week. These now stand out daily
;;; on my block agenda and I usually refile them during the day. I like to
;;; keep my refile task list empty.
;;;
;;; Code:
;;; http://doc.norang.ca/org-mode.html#CustomAgendaViews
(setq org-default-diary-file (concat org-directory "/" "diary.org"))

(provide 'xa-org-diary)
;;; xa-org-diary.el ends here
