;;(require 'xcscope+)
(dolist (p '(rustic
             paredit
             multiple-cursors
             vala-mode
             web-mode
             go-mode
             haskell-mode
             yaml-mode
             php-mode
             jinja2-mode
             js2-mode
             org))
  (progn
    (unless (package-installed-p p) (package-install p))
    (require p)))

(use-package hl-line
  :config (copy-face 'hl-line 'line-number-current-line))

(use-package dtrt-indent
  ;;:config (setq dtrt-indent-verbosity 3)
  )

(use-package paredit)
(use-package multiple-cursors)
(use-package vala-mode)

(use-package flycheck
  :config
  ;; turn on flychecking globally
  (add-hook 'after-init-hook #'global-flycheck-mode)  )

(use-package xcscope
  :config (cscope-setup))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

(defcustom jd:programming-language-major-modes
  '(prog-mode     ; This is the mode perl, makefile, lisp-mode, scheme-mode,
                                        ; emacs-lisp-mode, sh-mode, java-mode, c-mode, c++-mode,
                                        ; python-mode inherits from.
    lua-mode
    cmake-mode
    tex-mode                            ; LaTeX inherits
    ;;    sgml-mode                           ; HTML inherits
    css-mode
    nxml-mode
    diff-mode
    haskell-mode
    sql-mode
    rst-mode
    python-mode
    rustic-mode
    ;;    js2-mode
    )
  "What considering as programming languages.")

(defun xa:paredit-coding ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))


(defun company-show-doc-inhibit-popup (arg)
  "show doc popup but don't show company help on top of it"
  (interactive "P")
  (progn
    (setq company-tooltip-maximum-width 10)
    (company-show-doc-buffer)
    (setq company-tooltip-maximum-width 200)))

(defun jd:customize-programming-language-mode ()
  (progn
    (jd:font-lock-add-hack-keywords)
    (idle-highlight-mode 1)
    (rainbow-mode 1)
    (rainbow-delimiters-mode 1)
    (electric-pair-mode 1)
    (setq show-trailing-whitespace t)
    (flycheck-mode 1)
    (flyspell-prog-mode)
    (dtrt-indent-mode t)
    (company-mode 1)
    (display-line-numbers-mode)
    (local-set-key (kbd "TAB") #'company-indent-or-complete-common)
    (local-set-key (kbd "C-c C-h") #'company-show-doc-inhibit-popup)
    (xa:paredit-coding)))

(dolist (mode jd:programming-language-major-modes)
  (add-hook
   (intern (concat (symbol-name mode) "-hook"))
   'jd:customize-programming-language-mode))

(semantic-mode 1)
(global-git-commit-mode 1)
(global-semantic-stickyfunc-mode 1)
(global-semantic-idle-summary-mode 1)

(which-function-mode)

(setq mode-line-format (delete (assoc 'which-func-mode
                                      mode-line-format) mode-line-format)
      which-func-header-line-format '(which-func-mode ("" which-func-format)))
(setq mode-line-misc-info 'mode-line-format)

(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    (setq mode-line-format (delete (assoc 'which-func-mode
                                          mode-line-format) mode-line-format)
          header-line-format which-func-header-line-format)))


;; CC mode
(add-hook 'c-mode-common-hook
	  (lambda ()
            (when (fboundp 'doxymacs-mode)
              (doxymacs-mode 1))
	    (c-toggle-auto-newline nil)))
(add-hook 'c-initialization-hook
	  (lambda () (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)))
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)

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

(setq tab-width 4)
(setq indent-tabs-mode t)
(setq c-basic-offset 8)
(setq perl-indent-level 8)
(setq sh-basic-offset 8)
(setq js-indent-level 4)
(global-font-lock-mode)

(require 'pabbrev nil t)
(add-to-list 'auto-mode-alist '("~/src/.*linux.*/.*\\.[ch]$" . linux-c-mode))
(add-to-list 'auto-mode-alist '("\\.make$" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("Makefile.*" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[jt]s[x]?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.svelte$" . web-mode))
(add-to-list 'auto-mode-alist '("eos-image-builder/hooks" . shell-script-mode))


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

;; (defadvice show-paren-function (after my-echo-paren-matching-line activate)
;;   "If a matching paren is off-screen, echo the matching line."
;;   (when (char-equal (char-syntax (char-before (point))) ?\))
;;     (let ((matching-text (blink-matching-open)))
;;       (when matching-text
;;         (message matching-text)))))

(defun xa:setup-indent (n)
  ;; web development
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ;; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n) ; css-mode
  )



(defun xa:indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (buffer-end -1) (buffer-end 1))))

(provide 'xa-coding)
