;; dot emacs from Julien Danjou <julien@danjou.info>
;; Written since 2009!

;;(setenv "GPG_AGENT_INFO" (car (split-string (nth 1 (split-string (shell-command-to-string "gpg-agent --daemon") "=")) ";")))

;; Expand load-path
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/mu/mu4e") ; mu4e

;; Expand load-path
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/mu/mu4e") ; mu4e
;;(add-to-list 'load-path "~/.emacs.d/org-caldav") ; Load org-caldav

;; Generate autoloads
(let ((generated-autoload-file "~/.emacs.d/jd-autoloads.el"))
  (update-directory-autoloads "~/.emacs.d")
  (load generated-autoload-file)
  (let ((buf (get-file-buffer generated-autoload-file)))
    (when buf (kill-buffer buf))))

;; Each file named <somelibrary>.preload.el is loaded right now, e.g.
;; before the library is loaded. This should really not be needed, but some
;; libraries are badly designed and need this until I have the time to fix
;; them.
(dolist (file (directory-files user-emacs-directory))
  (when (string-match (format "^\\(.+\\)\\.preload\\.el$") file)
    (load (concat user-emacs-directory file))))

;; Each file named <somelibrary>.conf.el is loaded just after the library is
;; loaded.
(dolist (file (directory-files user-emacs-directory))
  (when (string-match (format "^\\(.+\\)\\.conf\\.el$") file)
    (eval-after-load (match-string-no-properties 1 file)
      `(load ,(concat user-emacs-directory file)))))

(setq auth-sources '("~/.authinfo.gpg"))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Install packages
(require 'package)

(require 'mu4e nil t)
(require 'iso-transl)
(require 'xa-ui)

(require 'jd-keybindings)
(require 'jd-daemon)
(require 'jd-coding)
(require 'ob)
(require 'org-crypt)
(require 'org-plot)
(require 'naquadah-theme)
(load-theme 'naquadah)
;;(require 'xa-theme)
;;(require 'org)

(require 'saveplace)
(require 'uniquify)
(require 'mmm-auto)
(require 'sws-mode nil t)
(require 'jade-mode nil t)

(require 'js2-mode nil t)
(require 'web-mode nil t)
(require 'popwin)
;;(require 'xa-irc)
(require 'xa-rust)
(popwin-mode 1)

(powerline-default-theme)
;;(require 'google-contacts-message)
;;(require 'google-contacts-gnus)

;; C source code
(setq frame-title-format '("" invocation-name ": %b"))
(setq ns-right-alternate-modifier nil)  ; Do not use the right Option as
                                        ; meta, rather use it for
                                        ; composition
(tool-bar-mode -1)			; Kill the toolbar
(setq scroll-step 1)
(setq visible-bell nil)                 ; This bugs with El Capitan
(setq-default fill-column 79)
(defalias 'yes-or-no-p 'y-or-n-p)
(set-default 'indicate-buffer-boundaries '((up . nil) (down . nil) (t . left)))
(setq next-screen-context-lines 5)      ; I want to keep more lines when
                                        ; switching pages
(setq use-dialog-box nil)               ; Seriously…
(put 'narrow-to-region 'disabled nil)
(set-default 'indent-tabs-mode nil)    ; always use spaces to indent, no tab
(set-frame-font "Iosevka Curly 11")
(setq user-full-name "Niv Sardi")

(global-hi-lock-mode 1)                 ; highlight stuff
(global-git-gutter-mode 1)              ; git gutter seems nice
(global-color-identifiers-mode 1)       ; amazing mode to have plenty of colors
(savehist-mode 1)

(browse-kill-ring-default-keybindings)
(which-func-mode 1)

;;(sml/setup)
;;(sml/apply-theme 'dark)
;;(sml/apply-theme 'light)

;;(sml/apply-theme 'respectful)

;; auto-close gpg buffers, taken from
;; http://stackoverflow.com/questions/15255080/how-to-auto-close-an-auto-encryption-mode-buffer-in-emacs

(defun dwim-kill-buffers-by-ext (ext &optional timeout)
  (interactive)
  (let ((timeout (or timeout 60))
        (buffers-killed 0))
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
          (when (string-match ext (buffer-name buffer))
          (let ((current-time (second (current-time)))
                (last-displayed-time (second buffer-display-time)))
            (when (> (- current-time last-displayed-time)
                     timeout)
              (message "Auto killing .gpg buffer '%s'" (buffer-name buffer))
              (when (buffer-modified-p buffer)
                (save-buffer))
              (kill-buffer buffer)
              (incf buffers-killed))))))
    (unless (zerop buffers-killed)
      (message "%s .%s buffers have been autosaved and killed" buffers-killed ext))))

(defun xa:kill-gpg-buffers (&optional timeout)
  (dwim-kill-buffers-by-ext "\\.gpg$" timeout))

(defun xa:kill-crypt-buffers (&optional timeout)
  (dwim-kill-buffers-by-ext "crypt" timeout))

(run-with-idle-timer 60 t 'xa:kill-gpg-buffers)
(run-with-idle-timer 60 t 'xa:kill-crypt-buffers)
(org-crypt-use-before-save-magic)
(put 'downcase-region 'disabled nil)

(provide 'init)
;;; init.el ends here
