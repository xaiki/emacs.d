(require 'company-web)

(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-tern)
(add-to-list 'company-backends 'company-irony)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
