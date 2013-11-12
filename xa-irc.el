(defun xa:erc-start ()
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd-naquadah")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd-oftc")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd-freenode")
  (erc-tls
   :server "prometheus.naquadah.org"
   :port 6666
   :nick "jd-lost-oasis"))

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
