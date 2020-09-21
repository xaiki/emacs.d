(require 'package)
(require 'xa-package)

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

(require-package 'org-plus-contrib t)

(dolist (package '(
                   flycheck-color-mode-line
                   naquadah-theme
                   elpy
                   crux
                   powerline
;;                   nm
;;                   notmuch
;;                   notmuch-labeler
                   ;;                   notmuch-unread
                   org-mind-map
                   org-superstar
                   dumb-jump
                   graphviz-dot-mode
                   vala-mode
                   fish-mode
                   svelte-mode
                   dockerfile-mode
                   docker-compose-mode
                   ido-completing-read+
                   systemd
                   fish-mode
                   tide
		   org-ehtml
		   ox-gfm
                   ox-minutes
		   oauth2		; Should be a dep of google-stuff
		   browse-kill-ring
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
		   ;; cmake-mode
		   goto-last-change
		   git-gutter
		   mmm-mode
		   clojure-mode
		   slime
		   auto-complete
		   auto-complete-clang-async
		   popwin
;;		   org-trello
;;                   highlight-current-line
                   idle-highlight-mode
;;                   mu4e-maildirs-extension
                   kubernetes
                   auto-dim-other-buffers
                   w3m
                   ac-js2
                   async
                   skewer-mode
                   impatient-mode
                   c-eldoc
		   request
                   color-identifiers-mode
                   ))
  (unless (package-installed-p package)
    (progn
      (message "installing %s" package)
      (package-install package))))

(provide 'init-package)
