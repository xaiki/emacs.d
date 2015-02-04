(require 'erc)
(defun* erc-znc (&rest spec
                       &key server port nick network
                       &allow-other-keys)
  "hack arround erc-tlc"
  (let* ((server  (plist-get spec :server))
          (port    (plist-get spec :port))
          (nick    (plist-get spec :nick))
          (network (plist-get spec :network))
          (secret  (let ((found (nth 0 (auth-source-search
                                        :host server
                                        :user (concat nick "#" network)
                                        :require '(:user :secret)
                                        ))))
                     (let ((secret (plist-get found :secret)))
                       (if (functionp secret)
                           (funcall secret)
                         secret)))))
       (erc-tls
        :server   server
        :port     port
        :nick     (concat nick "/" network)
        :password (concat nick "/" network ":" secret))))

(defun xa:erc-start (&optional dontask)
  (setq erc-prompt-for-password nil)
  (erc-znc
   :server "core.evilgiggle.com"
   :port 7778
   :nick "xaiki"
   :network "freenode")
  (erc-znc
   :server "core.evilgiggle.com"
   :port 7778
   :nick "xaiki"
   :network "oftc"))

(defun xa:erc-stop (&optional dontask)
  "Disconnect from IRC servers."
  (interactive)
  (let ((kill-buffer-query-functions (if dontask nil kill-buffer-query-functions)))
    (dolist (buffer (erc-buffer-list))
      (kill-buffer buffer))))

;;;###autoload
(defun xa:irc (&optional dontask)
  "Connect to IRC servers."
  (interactive)
  (let ((buflist (when (fboundp 'erc-buffer-list)
                   (erc-buffer-list))))
    (if buflist
        (if (or dontask (yes-or-no-p "Restart IRC?"))
            (progn
              (xa:erc-stop dontask)
              (xa:erc-start dontask))
          (message "Not doing anything."))
      (xa:erc-start))))

(add-to-list 'nm-connected-hook (lambda () (xa:irc t)))

(provide 'xa-irc)
