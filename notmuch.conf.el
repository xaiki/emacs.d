(setq notmuch-search-oldest-first nil)
(require 'notmuch-address)
(setq notmuch-address-command "~/bin/notmuch-goobook.sh")
(notmuch-address-message-insinuate)

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

(setq notmuch-address-selection-function 'xa:notmuch-address-selection-function)
(setq notmuch-address-selection-function 'xa:complete-to)
(setq notmuch-address-selection-function 'xa:completion-at-point)

(define-key notmuch-show-mode-map "d"
  (lambda ()
    (interactive)
      (notmuch-show-tag "+deleted")))

(define-key notmuch-search-mode-map "d"
  (lambda ()
    (interactive)
      (notmuch-search-tag "+deleted")))
