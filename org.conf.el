(require 'org-depend nil t)
(require 'ob-core)
(setq org-directory "~/Documents/org")
(run-at-time "00:59" 3600 'org-save-all-org-buffers)

(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

;; (org-babel-do-load-languages
;;  (quote org-babel-load-languages)
;;  (quote ((emacs-lisp . t)
;;          (dot . t)
;;          (ditaa . t)
;;          (R . t)
;;          (python . t)
;;          (ruby . t)
;;          (gnuplot . t)
;;          (clojure . t)
;;          (sh . t)
;;          (ledger . t)
;;          (org . t)
;;          (plantuml . t)
;;          (latex . t))))

(setq org-time-clocksum-use-effort-durations t)
(setq org-time-clocksum-format '(:years "%dy " :months "%dm " :weeks "%dw " :days "%dd " :hours "%dh" :require-hours nil :minutes "%02d" :require-minutes nil))
(setq org-hide-leading-stars t)
(setq org-src-fontify-natively t)
(setq org-startup-indented t)
(setq org-completion-use-iswitchb t)
(setq org-log-done t)
(setq org-log-into-drawer t)
(setq org-email-link-description-format "Email %c (%d): %s")
(setq org-link-frame-setup
      '((gnus . org-gnus-no-new-news)
	(file . find-file)))
(setq org-todo-keywords
      '((sequence "TODO(t!)"
                  "STARTED(s!)"
                  "DELEGATED(g@)"
                  "FEEDBACK(f!/@)"
                  "REWORK(r!/!)"
                  "VERIFY(v/!)"
                  "|"
                  "DONE(d!)"
                  "CANCELED(c@)")
        (sequence "PROJECT(j!)" "|" "CANCELED(c@)" "DONE(d!)")))
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-link-abbrev-alist
      '(("colissimo" . "http://www.coliposte.net/particulier/suivi_particulier.jsp?colispart=")))

(setq org-capture-templates (quote (("m" "Meeting" entry (file+headline (concat org-directory "/WORK.org") "Meetings") "* MEETING %^{Meeting Date and Time}T%? %^{Subject}
:PROPERTIES:
:LOCATION: %^{Location}
:END:
 %i
 %a") ("t" "Todo" entry (file+headline (concat org-directory "/TODO.org") "Tasks") "* TODO %?
  %i
  %a") ("j" "Journal" entry (file+headline (concat org-directory "/JOURNAL.org") "Journal") "* %U %?

  %i
  %a") ("i" "Idea" entry (file+headline (concat org-directory "/JOURNAL.org") "New Ideas") "*

%^{Title}
  %i
  %a") ("c" "Contacts" entry (file (concat org-directory "/Contacts.org"))
"* %(org-contacts-template-name)
  :PROPERTIES:
  :EMAIL: %(org-contacts-template-email)
  :END:"))))

(global-set-key "\C-cc" 'org-capture)

(setq org-mode-hook nil)
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook
          (lambda ()
            (add-hook
             (make-local-variable 'after-save-hook)
             (lambda ()
               (when (string-prefix-p (expand-file-name org-directory) buffer-file-name)
                 (call-process-shell-command
                  (format
                   "git commit -m \"%s: Org auto-commit\" -s %s && git push &"
                   (last (split-string buffer-file-name "/")) buffer-file-name )
                  nil 0))))))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)


(require 'org-crypt)
(defun jd:org-decrypt-entires-silently ()
  (let ((m (buffer-modified-p)))
      (org-decrypt-entries)
      (unless m
        (set-buffer-modified-p nil))))
(add-hook 'org-mode-hook 'jd:org-decrypt-entires-silently)
(add-hook 'org-mode-hook (lambda ()
                           (add-hook 'after-save-hook 'jd:org-decrypt-entires-silently)))

(require 'xa-org-export)

(when (require 'org-bullets nil t)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq font-lock-keywords-alist nil)
(font-lock-add-keywords 'org-mode
                        '(("^ +\\([-*]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))
                          ("^ *[|]*\\(|\\)"
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "┃"))))
                          ("^ *\\([|]\\)-"
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "┣"))))
                          ("^ *[|]*[-+\\|]\\(-\\)[-+\\|]"
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "━"))))
                          ("^ *[|]*[-+\\|][-+\\|]\\(-\\)"
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "━"))))
                          ("^ *[|]*[-+\\|]\\(-\\)"
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "━"))))
                          ("^ *[|]*-\\(+\\)-"
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "╋"))))
                          ("^ *[|][-+]*\\([|]\\) *$"
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "┫"))))))

(defun xa:make-it-right ()
  (interactive)
  (save-excursion
    (while (search-forward "\n\n" nil t)
      (fill-paragraph))))

(setq org-mobile-directory      (concat org-directory "/mobile"))
(setq org-mobile-inbox-for-pull (concat org-mobile-directory "/inbox.org"))

(setq org-crypt-key "EA3D162A")


(require 'org-mime)
(setq org-mime-library 'mml)

(add-hook 'message-mode-hook
          (lambda ()
            (local-set-key "\C-c\M-o" 'org-mime-htmlize)))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\C-c\M-o" 'org-mime-org-buffer-htmlize)))
