(defun xa:erc-start ()
  (erc-tls
   :server "core.evilgiggle.com"
   :port 7778
   :nick "freenode"))

(defun xa:erc-stop ()
  "Disconnect from IRC servers."
  (interactive)
  (dolist (buffer (erc-buffer-list))
    (kill-buffer buffer)))

;;;###autoload
(defun xa:irc ()
  "Connect to IRC servers."
  (interactive)
  (let ((buflist (when (fboundp 'erc-buffer-list)
                   (erc-buffer-list))))
    (if buflist
        (if (yes-or-no-p "Restart IRC?")
            (progn
              (xa:erc-stop)
              (xa:erc-start))
          (message "Not doing anything."))
      (xa:erc-start))))

(provide 'xa-irc)
