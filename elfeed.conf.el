(require 'elfeed)

(defun xa:elfeed-mark-as-read ()
  (interactive)
  (let ((entry (elfeed-search-selected :single)))
    (elfeed-untag entry 'unread)
    (elfeed-search-update-entry entry)
    (unless (use-region-p) (forward-line))))

(define-key elfeed-search-mode-map "d" #'xa:elfeed-mark-as-read)
