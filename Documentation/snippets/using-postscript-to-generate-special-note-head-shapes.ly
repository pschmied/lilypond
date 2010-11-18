%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.39"

\header {
  lsrtags = "editorial-annotations, tweaks-and-overrides"

%% Translation of GIT committish: 5a898cf43a2a78be6c3a58e4359dccd82196fbe7
  texidocfr = "
Lorsqu'il est impossible d'obtenir facilement une allure particulière
pour les têtes de note en recourant à la technique du @code{\\markup}, un
code Postscript peut vous tirer d'embarras.  Voici comment générer des
têtes ressemblant à des parallélogrammes.

"
  doctitlefr = "Utilisation de Postscript pour générer des têtes de note à l'allure particulière"

  texidoc = "
When a note head with a special shape cannot easily be generated with
graphic markup, PostScript code can be used to generate the shape.
This example shows how a parallelogram-shaped note head is generated.

"
  doctitle = "Using PostScript to generate special note head shapes"
} % begin verbatim

parallelogram =
  #(ly:make-stencil (list 'embedded-ps
    "gsave
      currentpoint translate
      newpath
      0 0.25 moveto
      1.3125 0.75 lineto
      1.3125 -0.25 lineto
      0 -0.75 lineto
      closepath
      fill
      grestore" )
    (cons 0 1.3125)
    (cons 0 0))

myNoteHeads = \override NoteHead #'stencil = \parallelogram
normalNoteHeads = \revert NoteHead #'stencil

\relative c'' {
  \myNoteHeads
  g4 d'
  \normalNoteHeads
  <f, \tweak #'stencil \parallelogram b e>4 d
}


