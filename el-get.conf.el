(setq el-get-is-lazy t)
(setq el-get-byte-compile nil)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(require 'el-get)
(el-get nil
        '(naquadah-theme
          highlight-indentation
          browse-kill-ring
          gnus
          go-mode
          el-get
          rainbow-mode
          google-maps
          google-weather
          multi-term
          erc-track-score
          markdown-mode
          browse-kill-ring
          magit
          gnuplot-mode
          emacs-jabber
          rainbow-delimiters
          htmlize
          lua-mode
          google-contacts
          yaml-mode
          haskell-mode
          php-mode
          cmake-mode
          goto-last-change
          idle-highlight-mode
          org-mode
          mmm-mode
          clojure-mode
          slime
          slime-annot
          doc-mode
          paredit
          jinja2-mode
          git-commit-mode))

(provide 'xa1-elget)
