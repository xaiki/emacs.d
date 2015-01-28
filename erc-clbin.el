;;; erc-clbin.el --- Clbining IRC messages in various ways

;; Copyright (C) 2001, 2002, 2003, 2004, 2006,
;;   2007, 2008 Free Software Foundation, Inc.

;; Based on erc-fill.el
;; Author: Andreas Fuchs <asf@void.at>
;;         Mario Lang <mlang@delysid.org>
;; URL: http://www.emacswiki.org/cgi-bin/wiki.pl?ErcClbining

;; Author: Niv Sardi <xaiki@debian.org>

;; This file is NOT part of GNU Emacs.

;; This file and GNU Emacs are free software; you can redistribute them
;; and/or modify them under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or (at your
;; option) any later version.

;; This file and GNU Emacs are distributed in the hope that they will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
;; Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This package implements clbining of messages sent and received.  Use
;; `erc-clbin-mode' to switch it on.

;;; Code:

(require 'erc)
(require 'request)

(defgroup erc-clbin nil
  "Clbining means to reformat long lines in different ways."
  :group 'erc)

;;;###autoload (autoload 'erc-clbin-mode "erc-clbin" nil t)
(erc-define-minor-mode erc-clbin-mode
  "Toggle ERC clbin mode.
With numeric arg, turn ERC clbin mode on if and only if arg is
positive.  In ERC clbin mode, messages in the channel buffers are
clbined."
  nil nil nil
  :global t :group 'erc-clbin
  (if erc-clbin-mode
      (erc-clbin-enable)
    (erc-clbin-disable)))

(defun erc-clbin-enable ()
  "Setup hooks for `erc-clbin-mode'."
  (interactive)
  (add-hook 'erc-send-pre-hook 'erc-clbin))

(defun erc-clbin-disable ()
  "Cleanup hooks, disable `erc-clbin-mode'."
  (interactive)
  (remove-hook 'erc-send-pre-hook 'erc-clbin))

;;;###autoload
(defun erc-clbin (text)
  "Clbins a text such that messages start at column `erc-clbin-static-center'."
  (let ((ret text))
    (when (string-match "\n" text)
      (request-response-data (request "https://clbin.com"
            :type "POST"
            :data (concat "clbin=" text)
            :sync t
            :parser 'buffer-string
            :success  (function* (lambda (&key data &allow-other-keys)
                                   (when data
                                     (setq ret (replace-regexp-in-string "\n?$" "?hl" data)))
                                   (erc-restore-text-properties))))))
    (setq str ret)))

(provide 'erc-clbin)

;;; erc-clbin.el ends here
;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;; arch-tag: 89224581-c2c2-4e26-92e5-e3a390dc516a
