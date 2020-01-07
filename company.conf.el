(require-package 'company-web)
(require-package 'company-tern)
(require-package 'company-racer)
(require 'company-web-html)

(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-web-fa+)
(add-to-list 'company-backends 'company-web-bootstrap+)
(add-to-list 'company-backends 'company-web-html)
(add-to-list 'company-backends 'company-web-jade)
(add-to-list 'company-backends 'company-web-slim)
(add-to-list 'company-backends 'company-tern)
(add-to-list 'company-backends 'company-irony)
(add-to-list 'company-backends 'company-jedi)
(add-to-list 'company-backends 'company-racer)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
