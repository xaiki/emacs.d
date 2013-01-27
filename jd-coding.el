(require 'xcscope+)
(require 'paredit)
(defcustom jd:programming-language-major-modes
  '(prog-mode     ; This is the mode perl, makefile, lisp-mode, scheme-mode,
                  ; emacs-lisp-mode, sh-mode, java-mode, c-mode, c++-mode,
                  ; python-mode inherits from.
    lua-mode
    cmake-mode
    tex-mode                            ; LaTeX inherits
    sgml-mode                           ; HTML inherits
    css-mode
    nxml-mode
    diff-mode
    haskell-mode
    sql-mode
    rst-mode)
  "What considering as programming languages.")

(defun jd:customize-programming-language-mode ()
  (jd:font-lock-add-hack-keywords)
  (idle-highlight-mode 1)
  (rainbow-mode 1)
  (rainbow-delimiters-mode 1)
  (setq show-trailing-whitespace t)
  (flymake-mode 1)
  (flyspell-prog-mode))

(dolist (mode jd:programming-language-major-modes)
  (add-hook
   (intern (concat (symbol-name mode) "-hook"))
   'jd:customize-programming-language-mode))

(semantic-mode 1)
(global-semantic-stickyfunc-mode 1)
(global-semantic-idle-summary-mode 1)

;; CC mode
(c-add-style "xa1"
	     '("gnu"
	       (c-offsets-alist
		(block-open . 0)
		(block-close . 0)
		(substatement-open . 0)
		(case-label . +)
		(func-decl-cont . 0)
		(inline-open . 0))
	       (c-hanging-braces-alist
                (brace-list-close nil)
		(defun-open after)
		(defun-close after)
		(class-open before after)
		(class-close before)
		(substatement-open after before)
		(substatement-close after))
	       (c-block-comment-prefix . "* ")
	       (c-echo-syntactic-information-p . t)
	       (c-basic-offset . 4)
               ;; Don't insert electric newlines on ;
               ;; That makes me CRAZY
               (c-hanging-semi&comma-criteria . nil)))

(add-hook 'c-mode-common-hook
	  (lambda ()
            (when (fboundp 'doxymacs-mode)
              (doxymacs-mode 1))
	    (c-set-style "xa1")
	    (c-toggle-auto-newline nil)))
(add-hook 'c-initialization-hook
	  (lambda () (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)))

(font-lock-add-keywords 'c-mode
                        '(("\\<.+_t\\>" . font-lock-type-face)
                          ("\\<bool\\>" . font-lock-type-face)
                          ("\\<foreach\\>" . font-lock-keyword-face)))
;; Torvalds a dit:
(defun linux-c-mode ()
  "C mode with adjusted values for the linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))

(setq tab-width 8)
(setq indent-tabs-mode t)
(setq c-basic-offset 8)
(setq perl-indent-level 4)
(setq sh-basic-offset 8)
(setq js-indent-level 8)

(require 'pabbrev nil t)
(add-to-list 'auto-mode-alist '("~/src/.*linux.*/.*\\.[ch]$" . linux-c-mode))
(add-to-list 'auto-mode-alist '("*.make$" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("Makefile.*" . makefile-gmake-mode))

(defun ffmpeg-c-mode ()
  "C mode with adjusted values for videolan."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4))

(defun vlc-c-mode ()
  "C mode with adjusted values for videolan."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4))

(defun sagem-c-mode ()
  "C mode with adjusted values for SAGEM."
  (interactive)
  (c-mode)
  (c-set-style "bsd")
  (setq tab-width 3)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 3))

(add-to-list 'auto-mode-alist '("~/src/.*vlc.*/.*\\.[ch]$" . vlc-c-mode))
(add-to-list 'auto-mode-alist '("~/Wrk/.*[Ii]cecast.*/.*\\.[ch]$" . vlc-c-mode))
(add-to-list 'auto-mode-alist '("~/Wrk/.*[Ff][Ff][Mm].*/.*\\.[ch]$" . vlc-c-mode))

(when (require 'kbuild-mode nil t)
  (add-to-list 'auto-mode-alist '(".*Config\\.in.*" . kbuild-mode)))


;; elisp
(defcustom jd:elisp-programming-major-modes
  '(emacs-lisp-mode
    lisp-interaction-mode
    ielm-mode)
  "Mode that are used to do Elisp programming.")

(dolist (mode jd:elisp-programming-major-modes)
  (let ((sym (intern (concat (symbol-name mode) "-hook"))))
    (add-hook sym 'turn-on-eldoc-mode)
    (add-hook sym 'enable-paredit-mode)))

;; lisp
(add-hook 'lisp-mode-hook (defun jd:turn-on-slime-mode ()
                            (slime-mode 1)
                            (slime-autodoc-mode 1)))

(provide 'jd-coding)
