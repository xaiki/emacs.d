(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#c5c8c6" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#1d1f21"))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(elfeed-feeds
   (quote
    ("http://feeds.feedburner.com/creditslips/feed" "http://thecodelesscode.com/rss" "http://sachachua.com/blog/feed/" "https://github.com/blog.atom" "http://what-if.xkcd.com/feed.atom" "http://whattheemacsd.com/atom.xml" "http://blag.xkcd.com/feed/" "\"http://blag.xkcd.com/feed/\"" "http://xkcd.com/atom.xml" "http://www.aljazeera.com/Services/Rss/?PostingId=2007731105943979989" "http://mindhacks.com/feed/" "http://www.pagina12.com.ar/diario/rss/ultimas_noticias.xml" "http://www.buenosairesherald.com/articles/rss.aspx" "http://rt.com/rss/" "http://feeds.feedburner.com/TechCrunch/")))
 '(fci-rule-color "#373b41")
 '(notmuch-saved-searches
   (quote
    (("inbox" . "tag:inbox")
     ("unread" . "tag:unread")
     ("Gmail.INBOX" . "folder:Gmail.INBOX")
     ("Opcode-ALL" . "folder:Gmail.xaiki@inaes.opcode"))))
 '(org-clock-persist-query-save t)
 '(org-clock-sound t)
 '(org-show-notification-handler (quote notifications-notify))
 '(org-trello-current-prefix-keybinding "C-c o")
 '(package-selected-packages
   (quote
    (erlang org-superstar dumb-jump graphviz-dot-mode dot-mode docker-compose-mode dockerfile-mode ido-completing-read+ org-mind-map systemd fish-mode flycheck-rust racer jinja2-mode php-mode yaml-mode haskell-mode go-mode web-mode xcscope vala-mode multiple-cursors dtrt-indent paredit smex naquadah-theme color-identifiers-mode request c-eldoc impatient-mode ac-js2 w3m auto-dim-other-buffers kubernetes idle-highlight-mode popwin auto-complete-clang-async auto-complete slime-annot slime clojure-mode mmm-mode git-gutter goto-last-change google-contacts lua-mode htmlize rainbow-delimiters magit-gh-pulls magit gnuplot-mode markdown-mode multi-term org-bullets ox-reveal google-maps rainbow-mode browse-kill-ring tide ox-minutes ox-gfm org-plus-contrib org-ehtml offlineimap oauth2 company-web company-tern company-racer)))
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
     (encoding . utf-8))))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-refine-added ((t (:inherit diff-refine-change :background "#007700"))))
 '(diff-refine-removed ((t (:inherit diff-refine-change :background "#770000"))))
 '(notmuch-message-summary-face ((t (:background "#111" :box (:line-width 1 :color "#222") :weight ultra-bold :height 1.2))))
 '(org-agenda-current-time ((t (:inherit org-time-grid :foreground "green" :weight bold))))
 '(org-block-background ((t (:background "#111111"))))
 '(org-block-begin-line ((t (:foreground "#008ED1" :background "#002E41"))))
 '(org-block-end-line ((t (:foreground "#008ED1" :background "#002E41")))))
