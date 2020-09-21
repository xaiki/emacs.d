(setq ido-enter-matching-directory 'first)
(setq ido-default-buffer-method 'selected-window
      ido-default-file-method 'selected-window
      ido-enable-flex-matching t
      ido-case-fold t) ; case insensitive matching
(setq ido-use-filename-at-point 'guess)
(ido-mode 1)                            ; Interactively Do Things
