;;; flycheck.conf.el --- settings for flycheck
;;; Commentary:
;;; get as much checking as possible
;;; Code:

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(use-package flycheck-posframe
  :config
  (progn
    (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
    (add-hook 'flycheck-posframe-inhibit-functions #'company--active-p)
    (setq flycheck-posframe-warning-prefix "⚠ "
      flycheck-posframe-info-prefix "··· "
      flycheck-posframe-error-prefix "✕ "
      flycheck-posframe-position 'window-bottom-right-corner)
    ;; (flycheck-posframe-configure-pretty-defaults)
    ))

;;(use-package flycheck-color-mode-line
;;  :config (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(setq flycheck-completing-read-function 'ido-completing-read)

(setq flycheck-check-syntax-automatically '(save mode-enabled idle-buffer-switch))
(setq flycheck-buffer-switch-check-intermediate-buffers t)
(setq flycheck-display-errors-delay 0.25)

(setq flycheck-checker-error-threshold nil)
;; Show indicators in the left margin
(setq flycheck-indication-mode 'left-fringe)

;; Adjust margins and fringe widths…
(defun xa:set-flycheck-margins ()
  (setq left-fringe-width 16 right-fringe-width 8
        left-margin-width 1 right--width 0)
  (flycheck-refresh-fringes-and-margins))

;; …every time Flycheck is activated in a new buffer
(add-hook 'flycheck-mode-hook #'xa:set-flycheck-margins)

(provide 'flycheck.conf)
;;; flycheck.conf ends here
