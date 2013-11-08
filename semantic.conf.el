(setq semantic-idle-summary-function
      (defun jd:semantic-format-tag-concise-or-full (tag &optional parent color)
        "Return the full prototype if we have enough size in the echo area to print it.
Otherwise, return a concise tag."
        (let ((ret (semantic-format-tag-prototype-default tag parent color)))
          (if (> (length ret)
                 (frame-width))
              (semantic-format-tag-concise-prototype-default tag parent color)
            ret))))
