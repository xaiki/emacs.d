;;; xa-rust --- settings for rust-lang
;;; Code:
(require-package 'company)
(require-package 'racer)
(require-package 'rust-mode)
(require-package 'flycheck)
(require-package 'flycheck-rust)

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook  #'company-mode)
(add-hook 'rust-mode-hook  #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-hook 'rust-mode-hook
          '(lambda ()
	     (setq racer-cmd (concat (getenv "HOME") "/.rust-dev/racer/target/release/racer"))
	     (setq racer-rust-src-path (concat (getenv "HOME") "/src/rust/src"))
             (local-set-key (kbd "TAB") #'company-indent-or-complete-common)
	     (electric-pair-mode 1)))

(provide 'xa-rust)
;;; xa-rust ends here

