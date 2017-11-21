(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(unless package-archive-contents    ;; Refresh the packages descriptions
  (package-refresh-contents))

(defun require-package (package)
  "Install given PACKAGE if it was not installed before."
  (if (package-installed-p package)
      t
    (progn
      (unless (assoc package package-archive-contents)
	(package-refresh-contents))
      (package-install package)))
  (require package))

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
;;                   highlight-current-line
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
		   request
                   ))
  (unless (package-installed-p package)
    (progn
      (message "installing %s" package)
      (package-install package))))
