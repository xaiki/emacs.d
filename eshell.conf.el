(require 'eshell)

(setq explicit-shell-file-name "zsh")
(setq explicit-zsh-args '("-c" "export EMACS=; stty echo; zsh"))
(setq comint-process-echoes t)

(push 'company-readline company-backends)
(add-hook 'rlc-no-readline-hook (lambda () (company-mode -1)))

