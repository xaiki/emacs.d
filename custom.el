(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("be789feb8143c030e0b5a9ab1410b8c6d171d38c1df8025822ea3294c643448e" "cc8528fcff6ff85ed132ea83e457a58ae0a49168c93bd752a8c446c61fefcdb5" default))
 '(org-clock-persist-query-save t t)
 '(org-clock-sound t)
 '(org-show-notification-handler 'notifications-notify t)
 '(package-selected-packages
   '(use-package emojify-logos emojify emoji-fontset all-the-icons company-box company-lsp slime-annot company-posframe xcscope web-mode w3m vala-mode tide tern systemd svelte-mode smex slime rustic request rainbow-mode rainbow-delimiters racer powerline popwin php-mode paredit ox-reveal ox-minutes ox-gfm org-superstar org-plus-contrib org-mind-map org-ehtml org-bullets offlineimap nyan-mode naquadah-theme multiple-cursors multi-term mmm-mode magit-gh-pulls lua-mode lsp-mode kubernetes jinja2-mode impatient-mode ido-completing-read+ idle-highlight-mode helm-ag haskell-mode graphviz-dot-mode goto-last-change google-maps google-contacts go-mode gnuplot-mode git-gutter fontawesome flycheck-rust flycheck-posframe flycheck-pos-tip flycheck-color-mode-line fish-mode elpy eglot dumb-jump dtrt-indent dockerfile-mode docker-compose-mode crux company-web company-racer color-identifiers-mode clojure-mode c-eldoc browse-kill-ring auto-dim-other-buffers auto-complete-clang-async auto-complete ac-js2))
 '(safe-local-variable-values
   '((eval ignore-errors "Write-contents-functions is a buffer-local alternative to before-save-hook"
           (add-hook 'write-contents-functions
                     (lambda nil
                       (delete-trailing-whitespace)
                       nil))
           (require 'whitespace)
           "Sometimes the mode needs to be toggled off and on."
           (whitespace-mode 0)
           (whitespace-mode 1))
     (whitespace-line-column . 80)
     (whitespace-style face trailing lines-tail)
     (require-final-newline . t)
     (encoding . utf-8))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
