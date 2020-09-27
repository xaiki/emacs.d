(defun xa:recalc-org-invoice ()
  (interactive)
     ;; Set the invoice date
     (beginning-of-buffer)
     (re-search-forward "{\\\\invoiceDate}{\\(.*\\)}")
     (goto-char (match-beginning 1))
     (kill-region (match-beginning 1) (match-end 1))
     (org-insert-time-stamp (current-time) nil t "" "")

     ;;
     ;; Update the summary table
     (beginning-of-buffer)
     (search-forward "| totaltarget")
     (org-table-recalculate t)
     (let ((balance (replace-regexp-in-string "_?$?" "" (org-table-get-constant "totaltarget"))))
       (message (format "balance: %s" balance))
       (beginning-of-buffer)
       (re-search-forward "{\\\\balance}{\\(.*\\)}")
       (goto-char (match-beginning 1))
       (kill-region (match-beginning 1) (match-end 1))
       (insert balance)))

(defun xa:org-next-invoice ()
  (interactive)
  ;;
  ;; Bump up the invoice number
  (beginning-of-buffer)
  (re-search-forward "{\\\\invoiceNo}{\\([0-9]+\\)}")
  (let ((n (string-to-number (match-string 1))))
    (goto-char (match-beginning 1))
    (kill-region (match-beginning 1) (match-end 1))
    (insert (format "%d" (1+ n))))
  ;;

  ;;
  ;;
  ;; Update the main clock table
  (beginning-of-buffer)
  (search-forward "#+BEGIN: clocktable")
  ;;
  ;; Here an advice is needed to make sure the Amount column is added
  ;; This advice is made unnecessary by this patch:
  ;; http://lists.gnu.org/archive/html/emacs-orgmode/2014-10/msg00002.html
  (unwind-protect
      (progn
        (defadvice org-table-goto-column
            (before
             always-make-new-columns
             (n &optional on-delim force)
             activate)
          "always adds new columns when we move to them"
          (setq force t))
        ;;
        (org-clocktable-shift 'right 1))
    ;;
    (ad-deactivate 'org-table-goto-column))

  (xa:recalc-org-invoice))

(provide 'xa-org-invoice)
