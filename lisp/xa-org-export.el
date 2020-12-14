(straight-use-package '(ox-odt :type git :host github :repo "kjambunathan/org-mode-ox-odt"))
;;(use-package ox-ehtml)
(use-package ox-gfm :after ox)
(use-package ox-reveal :after ox)
(use-package ox-hugo :after ox)

(add-to-list 'org-latex-default-packages-alist
             '(nil "fontspec"))
(add-to-list 'org-latex-default-packages-alist
             '("spanishmx" "babel"))


(advice-add 'org-export-as :before (lambda (a &optional b c d e)  (setq xa:org-is-exporting t)))
(advice-add 'org-export-as :after (lambda (a &optional b c d e)  (setq xa:org-is-exporting nil)))

(add-to-list 'org-latex-packages-alist
             '("AUTO" "babel" t ("pdflatex")))
(add-to-list 'org-latex-packages-alist
             '("AUTO" "polyglossia" t ("xelatex" "lualatex")))

(setenv "TEXINPUTS" (concat user-emacs-directory "latex"))
(setq org-export-latex-classes nil)
(setq xa:pdftk-cmd (concat "pdftk %b.pdf output %b.crypt.pdf owner_pw " (shell-command-to-string "apg -n 1 +s")))
(setq org-latex-pdf-process
      '("echo 'podman run -ti -v %o:/data:Z moss/xelatex  xelatex -interaction nonstopmode -output-directory %o %F' > /dev/stderr"
        "podman run -ti -v `basepath %O`:/data:Z moss/xelatex  xelatex -interaction nonstopmode -output-directory %o %f"
        "pdftk %b.pdf output %b.crypt.pdf owner_pw `apg -n 1 +s` || true"
        ))
(setq org-latex-compiler "xelatex")

(when (require 'org-latex nil t)
  (setq org-export-latex-listings t))

(eval-after-load 'ox '(require 'ox-koma-letter))
(eval-after-load 'ox-koma-letter
  '(progn
     (add-to-list 'org-latex-classes
                  '("koma-letter"
                    "\\documentclass\{scrlttr2\}
     \\setkomavar{frombank}{(1234)\\,567\\,890}
     \[DEFAULT-PACKAGES]
     \[PACKAGES]
     \[EXTRA]"))
     (setq org-koma-letter-default-class "koma-letter"
           org-koma-letter-from-address "Gualeguay 1225
Barracas
Capital Federal"
           org-koma-letter-phone  "+54 911 3574 7002"
           org-koma-letter-email  "xaiki@evilgiggle.com"
           org-koma-letter-place  "Buenos Aires"
           org-koma-letter-sender "Niv Sardi")))
(setq org-indent-mode nil)
(setq org-export-html-style
      "<style type=\"text/css\">
 <!--/*--><![CDATA[/*><!--*/
.src {
        background-color: #3f3f3f !important;
        color: #d8d8d8 !important;
        border-color: #1E2320 !important;
        }
  /*]]>*/-->
   </style>")

(setq org-latex-classes '(("article"
     "\\documentclass[11pt]{article}"
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
    ("report"
     "\\documentclass[11pt]{report}"
     ("\\part{%s}" . "\\part*{%s}")
     ("\\chapter{%s}" . "\\chapter*{%s}")
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
    ("book"
     "\\documentclass[11pt]{book}"
     ("\\part{%s}" . "\\part*{%s}")
     ("\\chapter{%s}" . "\\chapter*{%s}")
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
    ("beamer"
     "\\documentclass{beamer}"
     org-beamer-sectioning
     )))

(add-to-list 'org-latex-classes
          '("article"
             "\\documentclass{scrartcl}"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'org-latex-classes
          '("koma-article"
             "\\documentclass{scrartcl}"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
          '("koma-report"
            "\\documentclass{scrreprt}"
            ("\\part{%s}" . "\\part*{%s}")
	     ("\\chapter{%s}" . "\\chapter*{%s}")
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")))

(add-to-list 'org-latex-classes
          '("moderncv"
             "\\documentclass{moderncv}\\moderncvtheme[black]{classic}"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
          '("invoice"
             "\\documentclass[letterpaper]{dapper-invoice}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]

\\setmetadata{\\me}{Your Biz}{\\invoiceNo}{\\clientName}

\\defaultfontfeatures{ Path = ./Fonts/ }
\\usepackage{fontawesome}
"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; (add-to-list 'org-latex-classes
;;   ;; beamer class, for presentations
;;   '("beamer"
;;      "\\documentclass[11pt]{beamer}\n
;;       \\mode<{{{beamermode}}}>\n
;;       \\usetheme{{{{beamertheme}}}}\n
;;       \\usecolortheme{{{{beamercolortheme}}}}\n
;;       \\beamertemplateballitem\n
;;       \\setbeameroption{show notes}
;;       \\usepackage[utf8]{inputenc}\n
;;       \\usepackage[T1]{fontenc}\n
;;       \\usepackage{hyperref}\n
;;       \\usepackage{color}
;;       \\usepackage{listings}
;;       \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
;;   frame=single,
;;   basicstyle=\\small,
;;   showspaces=false,showstringspaces=false,
;;   showtabs=false,
;;   keywordstyle=\\color{blue}\\bfseries,
;;   commentstyle=\\color{red},
;;   }\n
;;       \\usepackage{verbatim}\n
;;       \\institute{{{{beamerinstitute}}}}\n
;;        \\subject{{{{beamersubject}}}}\n"

;;      ("\\section{%s}" . "\\section*{%s}")

;;      ("\\begin{frame}[fragile]\\frametitle{%s}"
;;        "\\end{frame}"
;;        "\\begin{frame}[fragile]\\frametitle{%s}"
;;        "\\end{frame}")))

(add-to-list 'org-latex-classes
  ;; beamer-covetel class, for presentations
  '("beamer-covetel"
     "\\input{preambulo.tex}\n"
     org-beamer-sectioning
     ))

(setq org-export-html-postamble-format '(
("en" "<p class=\"author\">Author: %a (%e)</p>\n<p class=\"date\">Date: %d</p>\n<p class=\"creator\">Generated by %c</p>\n<p class=\"xhtml-validation\">%v</p><p class=\"licence\">Licencia: <href a=\"http://creativecommons.org/licenses/by-sa/2.5/\">this work is released under the Creative Commons Attribution-ShareAlike 2.5 Generic (CC BY-SA 2.5) Licence\n</href></p>")
("es" "<p class=\"author\">Autor: %a (%e)</p>\n<p class=\"date\">Fecha: %d</p>\n<p class=\"creator\">Generado por %c</p>\n<p class=\"xhtml-validation\">%v</p><p class=\"licence\">Licencia: <href a=\"http://creativecommons.org/licenses/by-sa/2.5/ar\">este trabajo esta liberado bajo la Licencia Atribución-CompartirIgual 2.5 Argentina (CC BY-SA 2.5)\n</href></p>")))

(setq  org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")

(provide 'xa-org-export)
