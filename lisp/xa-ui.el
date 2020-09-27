(use-package ido
  :config (ido-mode 'both))

(use-package smex
  :config (smex-auto-update))

(use-package emojify
  :config (global-emojify-mode))
(use-package emojify-logos)

(use-package all-the-icons)

(use-package naquadah-theme
  :config
  (progn
    (load-theme 'naquadah)
    (naquadah-theme-set-faces
     'naquadah
     '(flycheck-error (:underline (:style line :color scarlet-red-1) t))
     '(flycheck-warning (:underline (:style line :color orange-2) t))
     '(flycheck-info (:underline (:style line :color chameleon-1) t))
     '(flymake-error (:underline (:style line :color scarlet-red-1) t))
     '(flymake-warning (:underline (:style line :color orange-2) t))
     '(flymake-info (:underline (:style line :color chameleon-1) t))
     '(flymake-note (:underline (:style line :color sky-blue-1) t)))))

;;(use-package solaire-mode)

(set-frame-font "Iosevka Curly 11")
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

(global-set-key "" 'ido-find-file)


;;(setq mode-line-format (xa:powerline-nyan-center-theme))
;;(setq mode-line-format '(:eval (list (nyan-create))))
(provide 'xa-ui)
