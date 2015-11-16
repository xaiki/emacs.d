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
  '(("jsx" . "\\.js[x]?\\'")))

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

(add-to-list 'auto-mode-alist '("\\.\\(html\\|tag\\|hbs\\)$" . web-mode))
;;(add-hook 'web-mode-hook 'skewer-mode)
;;(add-hook 'web-mode-hook 'skewer-html-mode)
(add-hook 'web-mode-hook 'xa:paredit-web)

(defadvice company-tern (before web-mode-set-up-ac-sources activate)
  "Set `tern-mode' based on current language before running company-tern."
  (if (equal major-mode 'web-mode)
      (let ((web-mode-cur-language
             (web-mode-language-at-pos)))
        (if (or (string= web-mode-cur-language "jsx")
                (string= web-mode-cur-language "javascript"))
            (unless tern-mode (tern-mode))
          (if tern-mode (tern-mode))))))


(setq web-mode-extra-snippets
      '(("jsx" . (("class" . ("class | extends React.Component {\nrender() {\nreturn (\n\n)\n}\n}"))
                  ("cssclass" . ("class | extends ReactCSS.Component {\nclasses() {\n'default': {\n}\n}\nrender() {\nreturn (\n\n)\n}\n}"))
                  ))))

(provide 'web-mode.conf)
;;; web-mode.conf.el ends here
