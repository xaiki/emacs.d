(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(unless package-archive-contents    ;; Refresh the packages descriptions
  (package-refresh-contents))

(dolist (package '(web-mode
;;                   nm
;;                   notmuch
;;                   notmuch-labeler
;;                   notmuch-unread 
                   nyan-mode
                   powerline
		   erc-image
		   tern
		   org-plus-contrib
		   org-ehtml
		   ox-gfm
                   naquadah-theme
		   oauth2		; Should be a dep of google-stuff
		   browse-kill-ring
		   go-mode
		   rainbow-mode
		   google-maps
		   multi-term
		   ;; hy-mode
		   markdown-mode
		   gnuplot-mode
		   magit
		   magit-gh-pulls
		   ;;magit-log-edit
		   rainbow-delimiters
		   htmlize
		   lua-mode
		   google-contacts
		   yaml-mode
		   haskell-mode
		   php-mode
		   ;; cmake-mode
		   goto-last-change
		   git-gutter
		   mmm-mode
		   clojure-mode
		   slime
		   jinja2-mode
		   helm
		   helm-css-scss
		   ac-helm
                   ac-html-bootstrap
		   auto-complete
		   auto-complete-clang-async
		   company-web
                   company-tern
		   popwin
;;		   org-trello
		   xcscope
		   paredit
                   smex
                   highlight-current-line
                   idle-highlight-mode
;;                   mu4e-maildirs-extension
                   org-bullets
                   auto-dim-other-buffers
                   offlineimap
                   flycheck
                   w3m
                   js2-mode
                   ac-js2
                   async
                   multiple-cursors
                   dtrt-indent
                   skewer-mode
                   impatient-mode
                   c-eldoc
                   xcscope
                   ))
  (unless (package-installed-p package)
    (progn
      (message "installing %s" package)
      (package-install package))))
