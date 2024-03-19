(TeX-add-style-hook
 "main"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("IEEEtran" "journal")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("csquotes" "autostyle=false" "style=english") ("tcolorbox" "listings" "skins") ("mdframed" "skipbelow=\\topskip" "skipabove=\\topskip") ("graphicx" "pdftex")))
   (add-to-list 'LaTeX-verbatim-environments-local "SaveVerbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "VerbatimOut")
   (add-to-list 'LaTeX-verbatim-environments-local "LVerbatim*")
   (add-to-list 'LaTeX-verbatim-environments-local "LVerbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "BVerbatim*")
   (add-to-list 'LaTeX-verbatim-environments-local "BVerbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "Verbatim*")
   (add-to-list 'LaTeX-verbatim-environments-local "Verbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "Verb*")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "Verb")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
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
   (LaTeX-add-bibliographies
    "IEEEabrv"
    "GA_reference.bib")
   (LaTeX-add-xcolor-definecolors
    "MyComments"
    "MyKeywords"
    "MyStrings"
    "MyIdentifiers"))
 :latex)

