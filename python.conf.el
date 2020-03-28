;;; python.conf --- simple python configuration
;;; Commentary:
;;; Code:
(defun xa:paredit-python ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))

(define-key python-mode-map (kbd "RET") 'newline-and-indent)
(define-key python-mode-map (kbd "S-<f5>") 'nosetests-compile)
(add-hook 'python-mode-hook 'xa:paredit-python)

(provide 'python.conf)
;;; python.conf.el ends here
