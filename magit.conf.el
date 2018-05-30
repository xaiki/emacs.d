(require-package 'company)
(setq magit-repo-dirs `("~/.emacs.d" "~/src"))
(setq magit-remote-ref-format 'remote-slash-branch)
(setq magit-completing-read-function 'magit-ido-completing-read)
(setq magit-save-some-buffers nil)

(add-hook 'magit-commit-setup-hook '(magit-commit-signoff t))
