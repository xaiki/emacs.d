(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-feeds
   (quote
    ("http://feeds.feedburner.com/creditslips/feed" "http://thecodelesscode.com/rss" "http://sachachua.com/blog/feed/" "https://github.com/blog.atom" "http://what-if.xkcd.com/feed.atom" "http://whattheemacsd.com/atom.xml" "http://blag.xkcd.com/feed/" "\"http://blag.xkcd.com/feed/\"" "http://xkcd.com/atom.xml" "http://www.aljazeera.com/Services/Rss/?PostingId=2007731105943979989" "http://mindhacks.com/feed/" "http://www.pagina12.com.ar/diario/rss/ultimas_noticias.xml" "http://www.buenosairesherald.com/articles/rss.aspx" "http://rt.com/rss/" "http://feeds.feedburner.com/TechCrunch/")))
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
 '(package-selected-packages
   (quote
    (notmuch-unread ob-browser erc-image erc-view-log erc-social-graph erc-colorize impatient-mode kite company znc yaml-mode xcscope web-mode wc-goal-mode w3m vala-mode stylus-mode smex smart-mode-line slime skewer-reload-stylesheets scss-mode readline-complete rainbow-mode rainbow-delimiters powerline popwin php-mode paredit org-trello org-plus-contrib org-ehtml org-caldav org-bullets org-beautify-theme offlineimap nyan-mode notmuch-labeler nm naquadah-theme mustache-mode multiple-cursors multi-term mu4e-maildirs-extension mmm-mode markdown-mode manage-minor-mode magit-log-edit magit-gh-pulls lua-mode less-css-mode jss jinja2-mode jade-mode idle-highlight-mode htmlize highlight-current-line helm-gtags helm-css-scss haskell-mode handlebars-sgml-mode handlebars-mode goto-last-change google-maps google-contacts go-mode gnuplot-mode git-gutter flycheck f esxml elnode elfeed-web dtrt-indent dot-mode dockerfile-mode ctags-update ctags css-eldoc company-tern company-irony company-c-headers coffee-mode clojure-mode chess c-eldoc browse-kill-ring auto-dim-other-buffers auto-complete-clang-async ascope anything-exuberant-ctags ac-js2 ac-ispell ac-helm 2048-game)))
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
