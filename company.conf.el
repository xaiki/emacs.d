;;; company.conf --- configure code-completion popups
;;; Commentary:
;;; we use posframe to try to tidy it all up
;;; Code:

(use-package flycheck)
(use-package company-web
  :config
  (progn
    (add-to-list 'company-backends 'company-web-html)
    (add-to-list 'company-backends 'company-web-jade)
    (add-to-list 'company-backends 'company-web-slim)))

(use-package company-box
  :config (progn
            (setq company-box-doc-enable nil)
            (push 'company-box-mode company-mode-hook)))

(use-package company-posframe
  :config (company-posframe-mode t))

(setq company-tooltip-maximum-width 1000)

(require 'company-web-html)

;;(add-hook 'after-init-hook 'global-company-mode)

;; (add-to-list 'company-backends 'company-tern)
;; (push company-irony company-backends)
;; (push company-jedi company-backends)

(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)

(add-hook 'flycheck-posframe-inhibit-functions #'company--active-p)

(provide 'company.conf)
;;; company.conf.el ends here
