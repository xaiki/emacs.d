(require 'elfeed)

(defun xa:elfeed-mark-as-read ()
  (interactive)
  (let ((entry (elfeed-search-selected :single)))
    (elfeed-untag entry 'unread)
    (elfeed-search-update-entry entry)
    (unless (use-region-p) (forward-line))))

(defun elfeed-search-format-date (date)
  "Format a date for printing in elfeed-search-mode."
  (let ((string (format-time-string "%m-%d" (seconds-to-time date))))
    (format "%-5.5s" string)))

(setq elfeed-search-title-max-width 100)

(define-key elfeed-search-mode-map "d" #'xa:elfeed-mark-as-read)
