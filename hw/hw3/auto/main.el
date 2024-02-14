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
    "graphicx"
    "xcolor"
    "hyperref"
    "wasysym"
    "mathrsfs"
    "datetime2"
    "boondox-cal"
    "bm"
    "amsmath"
    "amssymb"
    "cancel"
    "tikz")
   (TeX-add-symbols
    '("Cross" 2)
    '("delCross" 1)
    "daystilldue"
    "hourstilldue"
    "minutestilldue"
    "TimeUntilDue"
    "originalBibTeX")
   (LaTeX-add-bibliographies
    "references/references"))
 :latex)

