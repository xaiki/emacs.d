(use-package company
  :config (setq company-tooltip-align-annotations t))

(use-package tide
  :config ;; https://github.com/ananthakumaran/tide
  (progn
    (add-hook 'typescript-mode-hook #'setup-tide-mode)
    (add-hook 'before-save-hook 'tide-format-before-save))
  )

(use-package flycheck
  :config ;; disable jshint since we prefer eslint checking
  (progn
    (flycheck-add-mode 'javascript-eslint 'web-mode)
    (setq-default flycheck-disabled-checkers
                  (append flycheck-disabled-checkers
                          '(javascript-jshint)))))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)
  (message "tide mode setup"))

(use-package dtrt-indent
  :config
  (progn
    ;; hook into dtrt-indent
    (defun xa:web-mode-all-indent-offset (n)
      (setq
       web-mode-markup-indent-offset n
       web-mode-attr-indent-offset n
       web-mode-attr-value-indent-offset n
       web-mode-code-indent-offset n))

    (setq xa:web-mode-indent-offset 2)
    (add-to-list 'dtrt-indent-hook-mapping-list '(web-mode sgml xa:web-mode-indent-offset))
    (add-to-list 'dtrt-indent-hook-mapping-list '(web-mode default xa:web-mode-indent-offset))
    (add-to-list 'dtrt-indent-hook-mapping-list '(web-mode javascript xa:web-mode-indent-offset))
    (add-hook 'web-mode-hook 'dtrt-indent-adapt)))

(use-package color-identifiers-mode
  :config (add-to-list
 'color-identifiers:modes-alist
 `(web-mode . ("[^.][[:space:]]*"
               "\\_<\\([a-zA-Z_$]\\(?:\\s_\\|\\sw\\)*\\)"
               (nil font-lock-variable-name-face web-mode-param-name-face)))))

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

(setq web-mode-content-types-alist
      '(("jsx" . "\\.[jt]s[x]?\\'")))


;; hook into color-identifiers-mode



;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

(setq web-mode-auto-close-style 2)
(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-expanding t)
(setq web-mode-enable-auto-quoting nil)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-auto-opening t)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-auto-close-style 2)
(setq web-mode-enable-html-entities-fontification t)
(setq web-mode-enable-css-colorization t)

(defun xa:web-mode-hook () (interactive)
       (progn
         (message "runing hook")
         (xa:paredit-web)
         (xa:web-mode-all-indent-offset xa:web-mode-indent-offset)
         (when (string-match "[jt]s[x]?" (file-name-extension buffer-file-name))
           (progn
             (message "in js")
             (setup-tide-mode)))))

(add-to-list 'auto-mode-alist '("\\.\\(html\\|tag\\|hbs\\)$" . web-mode))
;;(add-hook 'web-mode-hook 'skewer-mode)
;;(add-hook 'web-mode-hook 'skewer-html-mode)
(add-hook 'web-mode-hook 'xa:web-mode-hook)

(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

(use-package tern)

(setq web-mode-extra-snippets
      '(("jsx" . (("class" . ("class | extends React.Component {\nrender() {\nreturn (\n\n)\n}\n}"))
                  ("cssclass" . ("class | extends ReactCSS.Component {\nclasses() {\n'default': {\n}\n}\nrender() {\nreturn (\n\n)\n}\n}"))
                  ))))

(provide 'web-mode.conf)
;;; web-mode.conf.el ends here
