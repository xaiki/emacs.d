(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(unless (package-read-all-archive-contents)
  ;; Fetch the remote list of packages.
  (package-refresh-contents))

(dolist (package '(naquadah-theme
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
		   magit-log-edit
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
		   git-commit-mode
		   helm
		   helm-css-scss
		   ac-helm
		   auto-complete
		   auto-complete-clang-async
		   popwin
		   org-trello
		   sublimity
		   xcscope
		   paredit
                   smex
                   highlight-current-line
                   idle-highlight-mode
                   mu4e-maildirs-extension
		   ))
  (unless (package-installed-p package)
    (package-install package)))
