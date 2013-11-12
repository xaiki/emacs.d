(require 'dbus)
(defvar nm-dbus-registration nil)
(setq nm-dbus-registration nil)
(defvar nm-connected-hook nil
  "Functions to run when network is connected.")
(defvar nm-connecting-hook nil
  "Functions to run when network is connecting.")
(defvar nm-disconnected-hook nil
  "Functions to run when network is disconnected.")

(defun gnus-nm-agent-unplug()
  "Kill IMAP server processes and unplug Gnus agent."
  (gnus-message 6 "Network is disconnected, unplugging Gnus agent.")
  (with-current-buffer gnus-group-buffer
    ;;(nntp-nuke-server-processes) ; optional, help prevent hangs in IMAP processes when network has gone down.
    (gnus-agent-toggle-plugged nil))
  (when (offlineimap-kill) (message "killed offlineimap"))
  )

(defun gnus-nm-agent-plug()
  "Plug Gnus agent."
  (gnus-message 6 "Network is connected, plugging Gnus agent.")
  (with-current-buffer gnus-group-buffer
    (gnus-agent-toggle-plugged t))
  (when (offlineimap) (message "launched offlineimap"))
  )

(defun nm-state-dbus-signal-handler (nmstate)
  "Handles NetworkManager signals and runs appropriate hooks."
  (cond ((= 20 nmstate)
          (progn (message "Network changed: disconnected")
                 (run-hooks 'nm-disconnected-hook)))
         ((= 70 nmstate)
          (progn (message "Network changed: connected")
                 (run-hooks 'nm-connected-hook)))
         ((= 40 nmstate)
          (progn (message "Network changed: connecting")
                 (run-hooks 'nm-connecting-hook)))
         (t (message "unhandled Network change state %d" nmstate))))

(defun nm-enable()
  "Enable integration with NetworkManager."
  (interactive)
  (when (not nm-dbus-registration)
    (progn (setq nm-dbus-registration
                 (dbus-register-signal :system
                  "org.freedesktop.NetworkManager" "/org/freedesktop/NetworkManager"
                  "org.freedesktop.NetworkManager" "StateChanged"
                  'nm-state-dbus-signal-handler))
           (message "Enabled integration with NetworkManager"))))

(defun nm-disable()
  "Disable integration with NetworkManager."
  (interactive)
  (when nm-dbus-registration
      (progn (dbus-unregister-object nm-dbus-registration)
             (setq nm-dbus-registration nil)
             (message "Disabled integration with NetworkManager"))))

(provide 'xa-nm)
