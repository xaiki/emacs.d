(setq ibuffer-modified-char ?✍)
(setq ibuffer-read-only-char ?✗)
(setq ibuffer-marked-char ?✓)
(setq ibuffer-deletion-char ?␡)
(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-saved-filter-groups
      `(("default"
         ,@(mapcar (lambda (directory)
                     `(,(file-name-nondirectory directory) (filename . ,directory)))
                   (remove-if-not 'file-directory-p
                                  (directory-files jd:projects-directory t "^[^\.][^\.]*" t)))
         ,@(mapcar (lambda (directory)
                     `(,(concat "Debian/" (file-name-nondirectory directory)) (filename . ,directory)))
                   (remove-if-not 'file-directory-p
                                  (directory-files "~/Debian/" t "^[^\.][^\.]*" t)))
         ("julien.danjou.info" (filename . ,(expand-file-name "~/Work/jdi")))
         ("Terminals" (mode . term-mode))
	 ("Org" (or (mode . org-mode)
                    (mode . org-agenda-mode)
                    (mode . calendar)))
         (".emacs.d" (filename . ,(expand-file-name "~/.emacs.d/")))
         ("Emacs Lisp" (mode . emacs-lisp-mode))
         ("IRC" (mode . erc-mode))
         ("Dired" (mode . dired-mode))
	 ("Gnus" (or (mode . gnus-group-mode)
		     (mode . gnus-article-mode)
		     (mode . message-mode)
		     (mode . gnus-server-mode)
		     (mode . gnus-summary-mode)))
	 ("manpages" (or (mode . Man-mode)
                         (mode . woman-mode)))
         ("Magit" (mode . magit-mode))
	 ("Help" (mode .  help-mode))
	 )))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))
