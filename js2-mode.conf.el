(defun xa:paredit-js ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (define-key js2-mode-map "{" 'paredit-open-curly)
  (define-key js2-mode-map "}" 'paredit-close-curly)
  (paredit-mode 1))

(setq js2-highlight-level 3)
(setq js2-strict-missing-semi-warning nil)
(setq js2-missing-semi-one-line-override t)

;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'js2-mode-hook 'xa:paredit-js)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)


