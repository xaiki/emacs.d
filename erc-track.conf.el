(setq erc-track-exclude-types '("NICK" "JOIN" "PART" "QUIT" "MODE"
                                "301" ; away notice
                                "305" ; return from awayness
                                "306" ; set awayness
                                "332" ; topic notice
                                "333" ; who set the topic
                                "353" ; Names notice
                                "324" ; modes
                                "329" ; channel creation date
                                ))
(setq erc-track-exclude-server-buffer t)
(setq erc-track-exclude '("*stickychan" "*status"))
(setq erc-track-showcount t)
(setq erc-track-shorten-start 1)
(setq erc-track-switch-direction 'importance)
(setq erc-track-visibility 'selected-visible)

;; This seems useful when using a visibility set to `selected-visible'.  If
;; you go to a frame where (nth 1 erc-modified-channels-alist) is
;; (current-buffer), when it will fail to switch. Recomputing will fix that.
(defadvice erc-track-switch-buffer
  (before jd:erc-track-switch-buffer-reset-display activate protect)
  "Recompute `erc-modified-channels-alist' before trying to
switch to a track channel."
  (when (eq major-mode 'erc-mode)
    (erc-track-modified-channels)))

(eval-after-load 'erc-track
  '(progn
     (defun erc-bar-move-back (n)
       "Moves back n message lines. Ignores wrapping, and server messages."
       (interactive "nHow many lines ? ")
       (re-search-backward "^.*<.*>" nil t n))

     (defun erc-bar-update-overlay ()
       "Update the overlay for current buffer, based on the content of
erc-modified-channels-alist. Should be executed on window change."
       (interactive)
       (let* ((info (assq (current-buffer) erc-modified-channels-alist))
	      (count (cadr info)))
	 (if (and info (> count erc-bar-threshold))
	     (save-excursion
	       (end-of-buffer)
	       (when (erc-bar-move-back count)
		 (let ((inhibit-field-text-motion t))
		   (move-overlay erc-bar-overlay
				 (line-beginning-position)
				 (line-end-position)
				 (current-buffer)))))
	   (delete-overlay erc-bar-overlay))))

     (defvar erc-bar-threshold 1
       "Display bar when there are more than erc-bar-threshold unread messages.")
     (defvar erc-bar-overlay nil
       "Overlay used to set bar")
     (setq erc-bar-overlay (make-overlay 0 0))
     (overlay-put erc-bar-overlay 'face '(:underline "black"))
     ;;put the hook before erc-modified-channels-update
     (defadvice erc-track-mode (after erc-bar-setup-hook
				      (&rest args) activate)
       ;;remove and add, so we know it's in the first place
       (remove-hook 'window-configuration-change-hook 'erc-bar-update-overlay)
       (add-hook 'window-configuration-change-hook 'erc-bar-update-overlay))
     (add-hook 'erc-send-completed-hook (lambda (str)
					  (erc-bar-update-overlay)))))
