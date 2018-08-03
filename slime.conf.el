(require-package 'slime-annot)

(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-autodoc slime-indentation slime-annot slime-fancy))
