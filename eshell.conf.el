(setq explicit-shell-file-name nil)
(setq explicit-zsh-args '("-c" "export EMACS=; stty echo; zsh"))
(setq comint-process-echoes t)

(use-package company
  :config
  (progn
    (push 'company-readline company-backends)
    (add-hook 'rlc-no-readline-hook (lambda () (company-mode -1)))))

(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-dakrone))
