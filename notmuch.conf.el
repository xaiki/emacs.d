(setq notmuch-search-oldest-first nil)

(defun xa:notmuch-address-selection-function (prompt collection initial-input)
  "Call (`completing-read'
      PROMPT COLLECTION nil nil INITIAL-INPUT 'notmuch-address-history)"
  (ido-completing-read
   prompt collection nil nil nil 'notmuch-address-history))

(defun xa:complete-to (prompt collection initial-input)
  (completion-in-region (xa:complete-email collection))
  nil)

(defun xa:completion-at-point (prompt collection initial-input)
  (completion-at-point))

;; (setq notmuch-address-selection-function 'xa:notmuch-address-selection-function)
;;(setq notmuch-address-selection-function 'xa:complete-to)
;;(setq notmuch-address-selection-function 'xa:completion-at-point)

(defun notmuch-search-toggle (tag)
  "Return a function that toggles TAG on the current item."
  (lambda ()
    (interactive)
    (if (member tag (notmuch-search-get-tags))
        (notmuch-search-tag (list (concat "-" tag) "+inbox"))
      (notmuch-search-tag (list (concat "+" tag) "-inbox" "-unread")))))

(defun expose (function &rest args)
  "Return an interactive version of FUNCTION, 'exposing' it to the user."
  (lambda ()
    (interactive)
    (apply function args)))

;; Notmuch mail listing keybindings.
(define-key notmuch-search-mode-map "g"
  'notmuch-poll-and-refresh-this-buffer)
(define-key notmuch-show-mode-map "d"
  (notmuch-search-toggle "deleted"))
(define-key notmuch-search-mode-map "d"
  (notmuch-search-toggle "deleted"))
(define-key notmuch-search-mode-map "S"
  (notmuch-search-toggle "spam"))
(define-key notmuch-hello-mode-map "g"
  'notmuch-poll-and-refresh-this-buffer)
(define-key notmuch-hello-mode-map "i"
  (expose #'notmuch-hello-search "tag:inbox"))
(define-key notmuch-hello-mode-map "u"
  (expose #'notmuch-hello-search "tag:unread"))
(define-key notmuch-hello-mode-map "a"
  (expose #'notmuch-hello-search "tag:archive"))

(require 'notmuch-address)
(setq notmuch-address-command "~/bin/notmuch-contact.py")
(notmuch-address-message-insinuate)
