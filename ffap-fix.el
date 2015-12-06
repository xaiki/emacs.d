(defun ffap-gopher-at-point ()
  "If point is inside a gopher bookmark block, return its URL.

Sets the variable `ffap-string-at-point-region' to the bounds of URL, if any."
  ;; `gopher-parse-bookmark' from gopher.el is not so robust
  (save-excursion
    (beginning-of-line)
    (if (looking-at ffap-gopher-regexp)
	(progn
	  (while (and (looking-at ffap-gopher-regexp) (not (bobp)))
	    (forward-line -1))
	  (or (looking-at ffap-gopher-regexp) (forward-line 1))
          (setq ffap-string-at-point-region (list (point) (point)))
	  (let ((type "1") path host (port "70"))
	    (while (looking-at ffap-gopher-regexp)
	      (let ((var (intern
			  (downcase
			   (buffer-substring (match-beginning 1)
					     (match-end 1)))))
		    (val (buffer-substring (match-beginning 2)
					   (match-end 2))))
		(set var val)
		(forward-line 1)))
            (setcar (cdr ffap-string-at-point-region) (point))
	    (if (and path (string-match "^ftp:.*@" path))
		(concat "ftp://"
			(substring path 4 (1- (match-end 0)))
			(substring path (match-end 0)))
	      (and (= (length type) 1)
		   host;; (ffap-machine-p host)
		   (concat "gopher://" host
			   (if (equal port "70") "" (concat ":" port))
			   "/" type path))))))))

(defun ffap-string-at-point (&optional mode)
  "Return a string of characters from around point.
MODE (defaults to value of `major-mode') is a symbol used to look up
string syntax parameters in `ffap-string-at-point-mode-alist'.
If MODE is not found, we use `file' instead of MODE.
If the region is active, return a string from the region.
Sets the variable `ffap-string-at-point' and the variable
`ffap-string-at-point-region'."
  (let* ((args
	  (cdr
	   (or (assq (or mode major-mode) ffap-string-at-point-mode-alist)
	       (assq 'file ffap-string-at-point-mode-alist))))
	 (pt (point))
	 (beg (if (use-region-p)
		  (region-beginning)
		(save-excursion
		  (skip-chars-backward (car args))
		  (skip-chars-forward (nth 1 args) pt)
		  (point))))
	 (end (if (use-region-p)
		  (region-end)
		(save-excursion
		  (skip-chars-forward (car args))
		  (skip-chars-backward (nth 2 args) pt)
		  (point)))))
    (setq ffap-string-at-point
	  (buffer-substring-no-properties
	   (setcar ffap-string-at-point-region beg)
	   (setcdr ffap-string-at-point-region end)))))
