;;; keybindings --- this defines default keybindings

(global-set-key "\C-cec" (lambda () (interactive)
			   (erc :server "core.evilgiggle.com" :port "6667"
				:nick "xaiki" :password "caca")))
(global-set-key "\C-ceu" (lambda () (interactive)
			   (erc :server "core.evilgiggle.com" :port "6667"
				:nick "xaiki" :password "caca2")))
(global-set-key "\C-ced" (lambda () (interactive)
			   (erc :server "core.evilgiggle.com" :port "6667"
				:nick "xaiki" :password "caca3")))
(global-set-key (kbd "C-SPC") 'set-mark-command)
(global-set-key "\C-cq"
                (defun jd:quit-emacs ()
                  (interactive)
                  (if (yes-or-no-p "Quit emacs? ")
                      (save-buffers-kill-emacs)
                    (message "Coward!"))))

(global-set-key [f11]
                (defun jd:set-frame-maximized ()
                  (interactive)
                  (set-frame-parameter nil 'fullscreen
                                       (if (eq (frame-parameter nil 'fullscreen) 'maximized) nil 'maximized))))

(global-set-key "\C-cnu"
                (lambda ()
                  (interactive)
                  (dired "/orion.naquadah.org:/srv/naquadah/upload")))

(global-set-key "\C-xm" 'compose-mail-other-window)

(global-set-key "\C-x\C-b" 'ibuffer)

(global-set-key "\M-/" 'hippie-expand)

(global-set-key (kbd "C-c C-,") 'magit-status)

(global-set-key (kbd "<f5>") 'recompile)

(use-package multi-term)
(global-set-key [f6] (lambda () (interactive)
                       (unless (multi-term-dedicated-exist-p)
                         (multi-term-dedicated-open))
                       (multi-term-dedicated-select)))
(global-set-key [S-f6] 'multi-term-dedicated-toggle)
(global-set-key [f9] 'multi-term-next)
(global-set-key [S-f9] 'multi-term)

(global-set-key "\C-c\C-b" 'browse-url)
(global-set-key "\C-c\C-f" 'find-function)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cL" 'org-insert-link-global)
(global-set-key "\C-co" 'org-open-at-point-global)
(global-set-key (kbd "<f10>") 'org-agenda-list)
(global-set-key (kbd "S-<f10>") 'org-todo-list)

(global-set-key (kbd "C-c g") 'jd:google)

(global-set-key (kbd "C-c d v") 'jd:debian-view-changelog)
(global-set-key (kbd "C-c d V") 'jd:debian-view-online-changelog)
(global-set-key (kbd "C-c d b") 'gnus-read-ephemeral-debian-bug-group)

(global-set-key (kbd "S-<f12>") 'jd:irc)

(global-set-key "\C-cis" 'erc-iswitchb)

(global-set-key (kbd "C-x C-/") 'goto-last-change)

(global-set-key (kbd "M-g M-v") 'flymake-display-err-menu-for-current-line)

(provide 'jd-keybindings)
;;; jd-keybindings.el ends here
