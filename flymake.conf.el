(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    `("pyflakes" (,local-file))))

(add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init))

(defvar jd:flymake-display-error-message-timer
  (run-with-idle-timer 1 t 'jd:flymake-display-err-for-current-line))

(defun jd:flymake-display-err-for-current-line ()
  "Display a message with errors/warnings for current line if it has errors and/or warnings."
  (interactive)
  (flycheck-display-error-at-point))
(provide 'flymake.conf)
;;; flymake.conf.el
