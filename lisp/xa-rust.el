;;; xa-rust --- settings for rust-lang
;;; Commentary:
;;; we're trying to emulate doom-emacs here
;;; Code:

(require 'xa-package)
(require-package 'helm-ag)
(require-package 'company)
(require-package 'racer)
(require-package 'rustic)
(require-package 'flycheck)

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rustic-mode))
(add-hook 'rustic-mode-hook  #'company-mode)
(add-hook 'rustic-mode-hook  #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-hook 'rust-mode-hook
          '(lambda ()
	     (setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))
	     (local-set-key (kbd "TAB") #'company-indent-or-complete-common)
	     (electric-pair-mode 1)))

(push 'rustic-clippy flycheck-checkers)
(setq lsp-rust-server 'rust-analyzer)
(setq rustic-lsp-client 'lsp-mode)
(setq lsp-rust-analyzer-cargo-watch-command "clippy")

(provide 'xa-rust)
;;; xa-rust ends here

