(defun require-package (package &optional no-require)
  "Install given PACKAGE if it was not installed before."
  (if (package-installed-p package)
      t
    (progn
      (unless (assoc package package-archive-contents)
       (package-refresh-contents))
      (package-install package)))
  (if no-require () (require package)))

(provide 'xa-package)
