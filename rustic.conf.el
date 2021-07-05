;;; xa-rust --- settings for rust-lang
;;; Commentary:
;;; we're trying to emulate doom-emacs here
;;; Code:

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package flycheck-rust
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package lsp-mode
  :config
  (progn
    (setq lsp-rust-server 'rust-analyzer)
    (setq rustic-lsp-client 'lsp-mode)
    (setq lsp-rust-analyzer-cargo-watch-command "clippy")))

(if (or (file-exists-p "~/.cargo/bin/cargo") ;; 'normal'
        (file-exists-p "~/.var/app/org.gnu.emacs/data/cargo/bin/cargo")) ;; 'flatpak'
    (if (file-exists-p "~/.cargo/bin/cargo")
        (setenv "PATH" (concat (getenv "PATH") ":" "~/.cargo/bin/"))
      (setenv "PATH" (concat (getenv "PATH") ":" "~/.var/app/org.gnu.emacs/data/cargo/bin/")))
  (progn
    (start-process-shell-command "Rust Install" "*rust-install*" "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y")
    (setenv "PATH" (concat (getenv "PATH") ":" ))))

(defun xa:inhibit-revert-buffer()
  (setq-local buffer-stale-function #'(lambda (&optional noconfirm) nil)))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rustic-mode))
(add-hook 'rustic-mode-hook  #'xa:inhibit-revert-buffer)
;;(add-hook 'rustic-mode-hook  #'rustdoc-mode)

(defun xa:pop-to-posframe (buffer &optional norecord)
  (when (posframe-workable-p)
    (posframe-show buffer
                   :position (point)
                   :timeout 5
                   :hidehandler 'posframe-hidehandler-when-buffer-switch)))

(setq rustic-format-display-method 'xa:pop-to-posframe)
(setq rustic-format-trigger 'on-save)
(push 'rustic-clippy flycheck-checkers)

(provide 'xa-rust)
;;; xa-rust ends here

