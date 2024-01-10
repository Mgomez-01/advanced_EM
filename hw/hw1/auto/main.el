(TeX-add-style-hook
 "main"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "12pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("datetime2" "calc")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art12"
    "amsmath"
    "graphicx"
    "xcolor"
    "hyperref"
    "wasysym"
    "mathrsfs"
    "datetime2"
    "boondox-cal")
   (TeX-add-symbols
    "daystilldue"
    "hourstilldue"
    "minutestilldue"
    "TimeUntilDue")
   (LaTeX-add-labels
    "stokes"
    "deldot")
   (LaTeX-add-bibliographies
    "references"))
 :latex)

