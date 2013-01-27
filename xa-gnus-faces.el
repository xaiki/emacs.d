(copy-face 'default 'gnus-default)
;;(set-face-attribute 'gnus-default nil :font "ProFontWindows-9")

(copy-face 'gnus-default 'mysubject)
(setq gnus-face-1 'mysubject)

(setq my-gnus-group-line-groupname-unread-face-1 nil)
(copy-face 'gnus-default 'my-gnus-group-line-groupname-unread-face-1)
(set-face-foreground 'my-gnus-group-line-groupname-unread-face-1 "yellow")

(setq my-gnus-group-line-groupname-read-face-3 nil)
(copy-face 'gnus-default 'my-gnus-group-line-groupname-read-face-3)
(set-face-foreground 'my-gnus-group-line-groupname-read-face-3 "green")

(setq my-gnus-group-line-groupname-unread-face-3 nil)
(copy-face 'gnus-default 'my-gnus-group-line-groupname-unread-face-3)
(set-face-foreground 'my-gnus-group-line-groupname-unread-face-3 "red")

(setq gnus-mouse-face-5 nil)
(copy-face 'gnus-default 'gnus-mouse-face-5)
(set-face-foreground 'gnus-mouse-face-5 "yellow")

(copy-face 'gnus-default 'mytime)
(set-face-foreground 'mytime "indianred4")
(setq gnus-face-2 'mytime)

(copy-face 'gnus-default 'mythreads)
(set-face-foreground 'mythreads "indianred4")
(setq gnus-face-3 'mythreads)

(copy-face 'gnus-default 'mygrey)
(set-face-foreground 'mygrey "grey")
(setq gnus-face-4 'mygrey)

(copy-face 'gnus-default 'myblack)
(set-face-foreground 'myblack "grey60")
(setq gnus-face-5 'myblack)

(copy-face 'gnus-default 'mybiggernumbers)
(set-face-foreground 'mybiggernumbers "indianred4")
(setq gnus-face-6 'mybiggernumbers)
(provide 'xa-gnus-faces)
