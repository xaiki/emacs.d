;; dot emacs from Julien Danjou <julien@danjou.info>
;; Written since 2009!

;;(setenv "GPG_AGENT_INFO" (car (split-string (nth 1 (split-string (shell-command-to-string "gpg-agent --daemon") "=")) ";")))

;; Expand load-path
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/mu/mu4e") ; mu4e
;;(add-to-list 'load-path "~/.emacs.d/org-caldav") ; Load org-caldav

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Generate autoloads
(let ((generated-autoload-file "~/.emacs.d/jd-autoloads.el"))
  (update-directory-autoloads "~/.emacs.d")
  (load generated-autoload-file)
  (let ((buf (get-file-buffer generated-autoload-file)))
    (when buf (kill-buffer buf))))

;; Each file named <somelibrary>.pre.conf.el is loaded right now, e.g.
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

(setq auth-sources '("~/.authinfo.gpg"
                     "secrets:session"
                      "secrets:Login"))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Install packages
(require 'package)

(require 'mu4e nil t)
(require 'iso-transl)
(require 'jd-keybindings)
(require 'jd-daemon)
(require 'jd-coding)
;;(require 'xa-theme)
(require 'org)
(require 'org-compat)
;;(require 'org-element)
(require 'ob)
(require 'org-crypt)
(require 'org-habit)
(require 'org-plot)
;;(require 'org-caldav)
(require 'naquadah-theme)
(require 'saveplace)
(require 'uniquify)
(require 'mmm-auto)
(require 'sws-mode nil t)
(require 'jade-mode nil t)

(require 'js2-mode nil t)
(require 'web-mode nil t)
(require 'popwin)
(require 'xa-irc)
(popwin-mode 1)

;;(require 'google-contacts-message)
;;(require 'google-contacts-gnus)

;; C source code
(setq frame-title-format '("" invocation-name ": %b"))
(menu-bar-mode -1)                      ; Kill the menu bar
(setq scroll-step 1)
(setq visible-bell t)
(setq-default fill-column 76)
(setq user-full-name "Niv Sardi")
(defalias 'yes-or-no-p 'y-or-n-p)
(set-default 'indicate-buffer-boundaries '((up . nil) (down . nil) (t . left)))
(setq next-screen-context-lines 5)      ; I want to keep more lines when
                                        ; switching pages
(setq use-dialog-box nil)               ; Seriously…

(put 'narrow-to-region 'disabled nil)
(set-default 'indent-tabs-mode nil)    ; always use spaces to indent, no tab

(display-time-mode 1)
(global-hi-lock-mode 1)                 ; highlight stuff
(global-git-gutter-mode 1)              ; git gutter seems nice
(savehist-mode 1)
(blink-cursor-mode 0)			; no blink!
(delete-selection-mode 1)		; Transient mark can delete/replace
(line-number-mode 1)			; Show line number
(column-number-mode 1)			; Show colum number

(setq org-support-shift-select t)

(show-paren-mode t)
(url-handler-mode 1)                    ; Allow to open URL
(mouse-avoidance-mode 'animate)         ; Move the mouse away
;;(ffap-bindings)                         ; Use ffap

;;(iswitchb-mode 1)
(ido-mode 'both)                            ; Interactively Do Things
(global-set-key "" 'ido-find-file)
(smex-initialize)			; ido for M-x

(browse-kill-ring-default-keybindings)
(which-func-mode 1)

(setq minibuffer-prompt-properties (quote (read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)))

(org-crypt-use-before-save-magic)
(auto-dim-other-buffers-mode)
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)			; Kill the toolbar
      (set-scroll-bar-mode 'right)		; Scrollbar on the right
      (scroll-bar-mode -1)			; But no scrollbar
      (global-hl-line-mode 1)			; Highlight the current line
      ))

;;(setq mode-line-format (xa:powerline-nyan-center-theme))
;;(setq mode-line-format '(:eval (list (nyan-create))))

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

(provide 'init)
;;; init.el ends here
