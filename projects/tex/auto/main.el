(TeX-add-style-hook
 "main"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("IEEEtran" "journal")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("csquotes" "autostyle=false" "style=english") ("tcolorbox" "listings" "skins") ("mdframed" "skipbelow=\\topskip" "skipabove=\\topskip") ("graphicx" "pdftex")))
   (TeX-run-style-hooks
    "latex2e"
    "IEEEtran"
    "IEEEtran10"
    "csquotes"
    "dirtytalk"
    "comment"
    "ulem"
    "lscape"
    "mathrsfs"
    "cancel"
    "amsmath"
    "amsthm"
    "enumitem"
    "amssymb"
    "appendix"
    "xcolor"
    "circuitikz"
    "tikz"
    "tikz-3dplot"
    "caption"
    "hyperref"
    "listings"
    "fancyvrb"
    "framed"
    "tcolorbox"
    "mdframed"
    "graphicx")
   (TeX-add-symbols
    '("figref" 1))
   (LaTeX-add-labels
    "fig:pix")
   (LaTeX-add-bibliographies
    "IEEEabrv"
    "reference.bib"))
 :latex)

