;;; xa-org-refile --- Org refile configuration
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
;;; http://doc.norang.ca/org-mode.html#Refiling
;;;
;;; 7.1 Refile Setup
;;;
;;; To refile tasks in org you need to tell it where you want to refile
;;; things.
;;;
;;; In my setup I let any file in org-agenda-files and the current file
;;; contribute to the list of valid refile targets.
;;;
;;; I've recently moved to using IDO to complete targets directly. I find
;;; this to be faster than my previous complete in steps setup. At first I
;;; didn't like IDO but after reviewing the documentation again and learning
;;; about C-SPC to limit target searches I find it is much better than my
;;; previous complete-in-steps setup. Now when I want to refile something I
;;; do C-c C-w to start the refile process, then type something to get some
;;; matching targets, then C-SPC to restrict the matches to the current
;;; list, then continue searching with some other text to find the target I
;;; need. C-j also selects the current completion as the final target. I
;;; like this a lot. I show full outline paths in the targets so I can have
;;; the same heading in multiple subtrees or projects and still tell them
;;; apart while refiling.

I now exclude DONE state tasks as valid refile targets. This helps to keep the refile target list to a reasonable size. 

(require 'xa-org-capture)
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)
(provide 'xa-org-refile)
;;; xa-org-refile.el ends here
