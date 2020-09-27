(setq paredit-indent-after-open nil)
(define-key paredit-mode-map (kbd "C-<left>") nil)
(define-key paredit-mode-map (kbd "C-<right>") nil)


(require 'eldoc) ; if not already loaded
(eldoc-add-command
 'paredit-backward-delete
 'paredit-close-round)

(eval-after-load 'paredit
  '(progn (define-key paredit-mode-map (kbd "{")
	    'paredit-open-curly)
	  (define-key paredit-mode-map (kbd "}")
	    'paredit-close-curly)
	  (define-key paredit-mode-map (kbd "M-}")
	    'paredit-close-curly-and-newline)))
