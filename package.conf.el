(require 'package)

;; straight.el bootstrap
(setq straight-use-package-by-default t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; (package-initialize)
;; 
;; (unless package-archive-contents    ;; Refresh the packages descriptions
;;   (package-refresh-contents))
;; 
;; (eval-when-compile
;;   (package-install 'use-package)
;;   (require 'use-package))
;; 
;; (dolist (package '(
;;                    org-plus-contrib
;;                    flycheck-color-mode-line
;;                    naquadah-theme
;;                    elpy
;;                    crux
;;                    powerline
;; ;;                   nm
;; ;;                   notmuch
;; ;;                   notmuch-labeler
;;                    ;;                   notmuch-unread
;;                    org-mind-map
;;                    org-superstar
;;                    dumb-jump
;;                    graphviz-dot-mode
;;                    vala-mode
;;                    fish-mode
;;                    svelte-mode
;;                    dockerfile-mode
;;                    docker-compose-mode
;;                    ido-completing-read+
;;                    systemd
;;                    fish-mode
;;                    tide
;; 		   org-ehtml
;; 		   ox-gfm
;;                    ox-minutes
;; 		   oauth2		; Should be a dep of google-stuff
;; 		   browse-kill-ring
;;                    rainbow-mode
;; 		   google-maps
;; 		   multi-term
;; 		   ;; hy-mode
;; 		   markdown-mode
;; 		   gnuplot-mode
;; 		   magit
;; 		   magit-gh-pulls
;; 		   ;;magit-log-edit
;; 		   rainbow-delimiters
;; 		   htmlize
;; 		   lua-mode
;; 		   google-contacts
;; 		   ;; cmake-mode
;; 		   goto-last-change
;; 		   git-gutter
;; 		   mmm-mode
;; 		   clojure-mode
;; 		   slime
;; 		   auto-complete
;; 		   auto-complete-clang-async
;; 		   popwin
;; ;;		   org-trello
;; ;;                   highlight-current-line
;;                    idle-highlight-mode
;; ;;                   mu4e-maildirs-extension
;;                    kubernetes
;;                    auto-dim-other-buffers
;;                    w3m
;;                    ac-js2
;;                    async
;;                    skewer-mode
;;                    impatient-mode
;;                    c-eldoc
;; 		   request
;;                    color-identifiers-mode
;;                    ))
;;   (unless (package-installed-p package)
;;     (progn
;;       (message "installing %s" package)
;;       (package-install package))))
;; 
(provide 'init-package)
