(setq magit-repo-dirs `(,jd:projects-directory "~/.emacs.d" "~/Debian" "~/.emacs.d/el-get"))
(setq magit-commit-signoff t)
(setq magit-remote-ref-format 'remote-slash-branch)
(setq magit-completing-read-function 'magit-iswitchb-completing-read)
(setq magit-save-some-buffers nil)
