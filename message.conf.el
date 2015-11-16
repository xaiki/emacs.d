(when
    (require 'xa-email nil t)
  (progn  
    (setq message-alternative-emails (xa:email-addresses-regexp))
    ;; When I reply, I don't want to have me in To or Cc
    (setq message-dont-reply-to-names (concat "\\("
					      (xa:email-addresses-regexp)
					      "\\|"
					      ;; Nor the Debian BTS
					      "^submit@bugs.debian\\.org$"
					      "\\)"))
    (setq message-confirm-send t)
    ;; Kill buffer when message is sent
    (setq message-kill-buffer-on-exit t)
    (setq message-elide-ellipsis "\n[…]\n\n")
    (setq message-citation-line-function 'message-insert-formatted-citation-line)
    (add-hook 'message-mode-hook 'footnote-mode)
    ;;(setq message-subscribed-address-functions '(gnus-find-subscribed-addresses))
    
    ;;(setq message-signature '(concat "Niv Sardi\n" (nth (random (length xa:message-signatures)) xa:message-signatures)))
    
    (setq message-send-mail-function 'message-smtpmail-send-it)
    
    (setq message-font-lock-keywords
	  (let ((content "[ \t]*\\(.+\\(\n[ \t].*\\)*\\)\n?"))
	    `((,(message-font-lock-make-header-matcher
		 (concat "^\\([Tt]o:\\)" content))
	       (1 'message-header-sub)
	       (2 'message-header-to nil t))
	      (,(message-font-lock-make-header-matcher
		 (concat "^\\(^[GBF]?[Cc][Cc]:\\|^[Rr]eply-[Tt]o:\\)" content))
	       (1 'message-header-name)
	       (2 'message-header-cc nil t))
	      (,(message-font-lock-make-header-matcher
		 (concat "^\\([Ss]ubject:\\)" content))
	       (1 'message-header-name)
	       (2 'message-header-subject nil t))
	      (,(message-font-lock-make-header-matcher
		 (concat "^\\([Nn]ewsgroups:\\|Followup-[Tt]o:\\)" content))
	       (1 'message-header-name)
       (2 'message-header-newsgroups nil t))
	      (,(message-font-lock-make-header-matcher
		 (concat "^\\(X-[A-Za-z0-9-]+:\\|In-Reply-To:\\)" content))
	       (1 'message-header-name)
	       (2 'message-header-xheader))
	      (,(message-font-lock-make-header-matcher
		 (concat "^\\([A-Z][^: \n\t]+:\\)" content))
	       (1 'message-header-name)
       (2 'message-header-other nil t))
	      ,@(if (and mail-header-separator
		 (not (equal mail-header-separator "")))
		    `((,(concat "^\\(" (regexp-quote mail-header-separator) "\\)$")
		       1 'message-separator))
		  nil)
	      ((lambda (limit)
		 (re-search-forward "\\(>\\(>\\(>\\(>\\(> .+\\)? ?.*\\)? ?.*\\)? ?.*\\)? ?.*\\)" 			    limit t))
	       (0 'mu4e-cited-1-face)
	       (1 'mu4e-cited-2-face)
	       (2 'mu4e-cited-3-face))
	      ("<#/?\\(multipart\\|part\\|external\\|mml\\|secure\\)[^>]*>"
	       (0 'message-mml)))))
    
    "^ *\\(\\(>+ ?\\)+\\)"
    "\\([ 	]*\\(\\w\\|[_.]\\)+>+\\|[ 	]*[]>|]\\)+"
    ))
