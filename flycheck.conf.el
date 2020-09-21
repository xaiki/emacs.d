;;; flycheck.conf.el --- settings for flycheck
;;; Commentary:
;;; get as much checking as possible
;;; Code:

(require 'xa-package)
(require-package 'flycheck-pos-tip)
(require-package 'flycheck-posframe)

(setq flycheck-completing-read-function 'ido-completing-read)
(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
(add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
(add-hook 'flycheck-posframe-inhibit-functions #'company--active-p)

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode)
  (setq flycheck-popup-tip-error-prefix "✕ "))

(setq flycheck-check-syntax-automatically '(save mode-enabled idle-buffer-switch))
(setq flycheck-buffer-switch-check-intermediate-buffers t)
(setq flycheck-display-errors-delay 0.25)
(setq flycheck-posframe-warning-prefix "⚠ "
        flycheck-posframe-info-prefix "··· "
        flycheck-posframe-error-prefix "✕ ")

(flycheck-posframe-configure-pretty-defaults)
(provide 'flycheck.conf)
;;; flycheck.conf ends here
