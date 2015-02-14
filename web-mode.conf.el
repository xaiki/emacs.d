(defun xa:paredit-web ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (define-key web-mode-map "{" 'paredit-open-curly)
  (define-key web-mode-map "}" 'paredit-close-curly)
;;  (define-key web-mode-map "<" 'paredit-open-angled)
;;  (define-key web-mode-map ">" 'paredit-close-angled)
  (paredit-mode 1))

(setq web-mode-engines-alist
      '(("ctemplate" . "\\.html\\'")))

(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-expanding t)
(setq web-mode-enable-auto-quoting nil)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-auto-opening t)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-auto-close-style 2)

(add-to-list 'auto-mode-alist '("\\.\\(html\\|tag\\|hbs\\)$" . web-mode))
(add-hook 'web-mode-hook 'skewer-mode)
(add-hook 'web-mode-hook 'xa:paredit-web)
(add-hook 'web-mode-hook 'skewer-html-mode)

(provide 'web-mode.conf)
;;; web-mode.conf.el ends here
