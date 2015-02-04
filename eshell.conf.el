(require 'eshell)
(eval-after-load 'esh-opt
  (progn
    (require 'eshell-prompt-extras)
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-lambda)))

(setq explicit-shell-file-name "zsh")
(setq explicit-zsh-args '("-c" "export EMACS=; stty echo; zsh"))
(setq comint-process-echoes t)

(push 'company-readline company-backends)
(add-hook 'rlc-no-readline-hook (lambda () (company-mode -1)))

