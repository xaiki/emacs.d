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
;; `erc-clbin-mode' to switch it on.  Customize `erc-clbin-function' to
;; change the style.

;;; Code:

(require 'erc)
(require 'erc-stamp); for the timestamp stuff
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

(defcustom erc-clbin-prefix nil
  "Values used as `clbin-prefix' for `erc-clbin-variable'.
nil means clbin with space, a string means clbin with this string."
  :group 'erc-clbin
  :type '(choice (const nil) string))

(defcustom erc-clbin-function 'erc-clbin-static
  "Function to use for clbining messages.

Variable Clbining with an `erc-clbin-prefix' of nil:

<shortnick> this is a very very very long message with no
	    meaning at all

Variable Clbining with an `erc-clbin-prefix' of four spaces:

<shortnick> this is a very very very long message with no
    meaning at all

Static Clbining with `erc-clbin-static-center' of 27:

		<shortnick> foo bar baz
	 <a-very-long-nick> foo bar baz quuuuux
		<shortnick> this is a very very very long message with no
			    meaning at all

These two styles are implemented using `erc-clbin-variable' and
`erc-clbin-static'.  You can, of course, define your own clbining
function.  Narrowing to the region in question is in effect while your
function is called."
  :group 'erc-clbin
  :type '(choice (const :tag "Variable Clbining" erc-clbin-variable)
                 (const :tag "Static Clbining" erc-clbin-static)
                 function))

(defcustom erc-clbin-static-center 27
  "Column around which all statically clbined messages will be
centered.  This column denotes the point where the ' ' character
between <nickname> and the entered text will be put, thus aligning
nick names right and text left."
  :group 'erc-clbin
  :type 'integer)

(defcustom erc-clbin-variable-maximum-indentation 17
  "If we indent a line after a long nick, don't indent more then this
characters. Set to nil to disable."
  :group 'erc-clbin
  :type 'integer)

(defcustom erc-clbin-column 78
  "The column at which a clbined paragraph is broken."
  :group 'erc-clbin
  :type 'integer)

(defcustom erc-clbin-min-lines 3
  "how many lines must be pasted before passing to clbin."
  :group 'erc-clbin
  :type 'integer)

;;;###autoload
(defun erc-clbin-old ()
  "Clbin a region using the function referenced in `erc-clbin-function'.
You can put this on `erc-pre-send-hook'."
  (unless (erc-string-invisible-p (buffer-substring (point-min) (point-max)))
    (when erc-clbin-function
      ;; skip initial empty lines
      (goto-char (point-min))
      (save-match-data
        (while (and (looking-at "[ \t\n]*$")
                    (= (forward-line 1) 0))))
      (unless (eobp)
        (save-restriction
          (narrow-to-region (point) (point-max))
          (funcall erc-clbin-function))))))

;;;###autoload
(defun erc-clbin (text)
  "Clbins a text such that messages start at column `erc-clbin-static-center'."
  (let ((ret text))
    (when (string-match (mapconcat 'identity (make-list erc-clbin-min-lines "\n.*") "") text)
      (request-response-data (request "https://clbin.com"
            :type "POST"
            :data (concat "clbin=" text)
            :sync t
            :parser 'buffer-string
            :success  (function* (lambda (&key data &allow-other-keys)
                                   (when data
                                     (setq ret data))
                                   (erc-restore-text-properties))))))
    (setq str ret)))

(provide 'erc-clbin)

;;; erc-clbin.el ends here
;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;; arch-tag: 89224581-c2c2-4e26-92e5-e3a390dc516a
