(require-package 'naquadah-theme)
(require-package 'smex)

(set-face-attribute 'default nil :height 140)
(setq-default line-spacing 0.4)

(menu-bar-mode -1)                      ; Kill the menu bar
(setq scroll-step 1)
(setq visible-bell t)
(setq-default fill-column 76)

(defalias 'yes-or-no-p 'y-or-n-p)
(set-default 'indicate-buffer-boundaries '((up . nil) (down . nil) (t . left)))
(setq next-screen-context-lines 5)      ; I want to keep more lines when
                                        ; switching pages
(setq use-dialog-box nil)               ; Seriously…

(put 'narrow-to-region 'disabled nil)
(set-default 'indent-tabs-mode nil)    ; always use spaces to indent, no tab

(display-time-mode 1)
(blink-cursor-mode 0)			; no blink!
(delete-selection-mode 1)		; Transient mark can delete/replace
(line-number-mode 1)			; Show line number
(column-number-mode 1)			; Show colum number

(show-paren-mode t)
(url-handler-mode 1)                    ; Allow to open URL
(mouse-avoidance-mode 'animate)         ; Move the mouse away
;;(ffap-bindings)                         ; Use ffap

(setq minibuffer-prompt-properties (quote (read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)))

(auto-dim-other-buffers-mode)
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)			; Kill the toolbar
      (set-scroll-bar-mode 'right)		; Scrollbar on the right
      (scroll-bar-mode -1)			; But no scrollbar
      (global-hl-line-mode 1)			; Highlight the current line
      ))

;;(iswitchb-mode 1)
(ido-mode 'both)                            ; Interactively Do Things
(global-set-key "" 'ido-find-file)
(smex-initialize)			; ido for M-x


;;(setq mode-line-format (xa:powerline-nyan-center-theme))
;;(setq mode-line-format '(:eval (list (nyan-create))))
(provide 'xa-ui)
