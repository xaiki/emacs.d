;; (require-package 'mmm-mode)

;; (mmm-add-classes
;;  '((css-inline
;;     :submode css-mode
;;     :face mmm-declaration-submode-face
;;     :front "[^a-zA-Z]css`"
;;     :back "`")
;;    (js-inline
;;     :submode js-mode
;;     :face mmm-declaration-submode-face
;;     :front "```javascript"
;;     :back "```"
;;     )
;;    (html-inline
;;     :submode web-mode
;;     :face mmm-declaration-submode-face
;;     :front "```html"
;;     :back "```"
;;     )))
;; (mmm-add-mode-ext-class 'web-mode nil 'css-inline)
;; (mmm-add-mode-ext-class 'markdown-mode nil 'js-inline)
;; (mmm-add-mode-ext-class 'markdown-mode nil 'html-inline)
;; (setq mmm-global-mode 'maybe)
;; ;;(setq mmm-submode-decoration-level 0)
