(require 'simplenote2)
(setq simplenote2-email "x@btn.sh")
(simplenote2-setup)
(add-hook 'simplenote2-note-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-t") 'simplenote2-add-tag)
            (local-set-key (kbd "C-c C-e") 'simplenote2-push-buffer)
            (local-set-key (kbd "C-c C-d") 'simplenote2-pull-buffer)))
(setq simplenote2-markdown-notes-mode 'markdown-mode)
