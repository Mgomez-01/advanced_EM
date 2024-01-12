(TeX-add-style-hook
 "main"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "12pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("datetime2" "calc")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art12"
    "graphicx"
    "xcolor"
    "hyperref"
    "wasysym"
    "mathrsfs"
    "datetime2"
    "boondox-cal"
    "bm"
    "amsmath"
    "amssymb")
   (TeX-add-symbols
    "daystilldue"
    "hourstilldue"
    "minutestilldue"
    "TimeUntilDue")
   (LaTeX-add-labels
    "stokes"
    "deldot")
   (LaTeX-add-environments
    '("gathered" LaTeX-env-args ["argument"] 0))
   (LaTeX-add-bibliographies
    "references/references"))
 :latex)

