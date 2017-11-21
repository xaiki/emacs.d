(require-package 'powerline)
(require-package 'fontawesome)
(require-package 'nyan-mode)

(defcustom xa:mode-line-ignore-alist '("Dim" "Fly[^ ]+" "Rbow" "Paredit")
  "list of regexp that will be ignored in the minor mode mode-line"
  :group 'powerline)

  (defun xa:fontawesome (symbol)
    (propertize (fontawesome symbol) 'face '(:family "FontAwesome")))

  (defcustom xa:major-mode-line-regexp-map
    '(("[Ee]macs-?"          . "𝛏")
      ("[Jj]ava[Ss]cript"    . "JS")
      ("[Ss]hell-?[Ss]cript" . "$"))
    "list of (regexp . rep) pairs that will be applied on the
          major mode when building the mode-line"
    :group 'powerline)

  (defcustom xa:minor-mode-line-regexp-map
    `(("Fly"        . ,(xa:fontawesome "bolt"))
      ("[Tt]ern"    . ,(xa:fontawesome "code"))
      ("[Ss]kewer"  . "Sk")
      ("GitGutter"  . ,(xa:fontawesome "code-fork"))
      ("Fill"       . ,(xa:fontawesome "bars"))
      ("company"    . ,(xa:fontawesome "compass"))
      ("ElDoc"      . ,(xa:fontawesome "info-circle")))
    "list of (regexp . rep) pairs that will be applied on the
          minor mode when building the mode-line"
    :group 'powerline)

(set-face-attribute 'mode-line nil
                    :family "Fira Sans Condensed")

(defun xa:build-ignore-cons-cells ()
  (let ((ret ()))
    (mapcar (lambda (m)
            (cons (concat " " m) ""))
        xa:mode-line-ignore-alist)))

(defun xa:format-mode-line (arg map)
  (when (stringp arg)
    (mapc
     (lambda (dup)
       (setq arg (replace-regexp-in-string (car dup) (cdr dup) arg)))
     (append (xa:build-ignore-cons-cells) map)))
  (format-mode-line arg))

(defpowerline powerline-major-mode
  (propertize (xa:format-mode-line mode-name xa:major-mode-line-regexp-map)
              'mouse-face 'mode-line-highlight
              'help-echo "Major mode\n\ mouse-1: Display major mode menu\n\ mouse-2: Show help for major mode\n\ mouse-3: Toggle minor modes"
              'local-map (let ((map (make-sparse-keymap)))
                           (define-key map [mode-line down-mouse-1]
                             `(menu-item ,(purecopy "Menu Bar") ignore
                                         :filter (lambda (_) (mouse-menu-major-mode-map))))
                           (define-key map [mode-line mouse-2] 'describe-mode)
                           (define-key map [mode-line down-mouse-3] mode-line-mode-menu)
                           map)))

(defpowerline powerline-minor-modes
  (mapconcat (lambda (mm)
               (propertize mm
                           'mouse-face 'mode-line-highlight
                           'help-echo "Minor mode\n mouse-1: Display minor mode menu\n mouse-2: Show help for minor mode\n mouse-3: Toggle minor modes"
                           'local-map (let ((map (make-sparse-keymap)))
                                        (define-key map
                                          [mode-line down-mouse-1]
                                          (powerline-mouse 'minor 'menu mm))
                                        (define-key map
                                          [mode-line mouse-2]
                                          (powerline-mouse 'minor 'help mm))
                                        (define-key map
                                          [mode-line down-mouse-3]
                                          (powerline-mouse 'minor 'menu mm))
                                        (define-key map
                                          [header-line down-mouse-3]
                                          (powerline-mouse 'minor 'menu mm))
                                        map)))
             (split-string (xa:format-mode-line (format-mode-line minor-mode-alist) xa:minor-mode-line-regexp-map))
             (propertize " " 'face face)))

(defun xa:powerline-nyan-center-theme ()
  "Setup a mode-line with major and minor modes centered."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          powerline-default-separator
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           powerline-default-separator
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list ;;(powerline-raw "%*" nil 'l)
                                     ;;(powerline-buffer-size nil 'l)
                                     ;;(powerline-raw " ")
                                     ;;(funcall separator-left mode-line face2 )
                                     (powerline-buffer-id face2 'l)
                                     (powerline-raw " " face2)
                                     (funcall separator-left face2 face1)
                                     (powerline-narrow face1 'l)
                                     (powerline-vc face1)))
                          (rhs (list (powerline-raw global-mode-string face1 'r)
                                     (powerline-raw "%4l" face1 'r)
                                     (powerline-raw ":" face1)
                                     (powerline-raw "%3c" face1 'r)
                                     (funcall separator-right face1 mode-line)
                                     (nyan-create)
                                     (powerline-raw " ")
                                     (powerline-raw "%6p" nil 'r)
;;                                     (powerline-hud face2 face1)
                                     ))
                          (center (list (powerline-raw " " face1)
                                        (funcall separator-left face1 face2)
                                        (when (boundp 'erc-modified-channels-object)
                                          (powerline-raw erc-modified-channels-object face2 'l))
                                        (powerline-major-mode face2 'l)
                                        (powerline-raw " " face2)
                                        (funcall separator-left face2 mode-line)
;;                                        (powerline-process face2)

                                        (powerline-minor-modes mode-line 'l)
                                        (powerline-raw " " mode-line)
                                        (funcall separator-right mode-line face1))))
                     (concat (powerline-render lhs)
                             (powerline-fill-center face1 (/ (powerline-width center) 2.0))
                             (powerline-render center)
                             (powerline-fill face1 (powerline-width rhs))
                             (powerline-render rhs)))))))

(provide 'xa-powerline)
