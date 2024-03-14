(TeX-add-style-hook
 "main"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "12pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("datetime2" "calc") ("geometry" "margin=0.75in")))
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
    "amsthm"
    "amssymb"
    "amsbsy"
    "gensymb"
    "cancel"
    "tikz"
    "geometry")
   (TeX-add-symbols
    '("Cross" 2)
    '("delCross" 1)
    "daystilldue"
    "hourstilldue"
    "minutestilldue"
    "TimeUntilDue"
    "originalBibTeX")
   (LaTeX-add-labels
    "fig:8-2"
    "fig:8-2-2"
    "fig:ansys_model_8-2"
    "fig:9-14"
    "fig:9-14des"
    "fig:11-2"
    "fig:error_11-20"
    "fig:endResults")
   (LaTeX-add-bibliographies
    "references/references"))
 :latex)

