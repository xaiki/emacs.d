(add-to-list 'load-path "~/.emacs.d/org-sync") ; Load org-sync
(require 'os)
(mapc 'load '("org-element" "os" "os-bb" "os-github"  "os-rmine"))
