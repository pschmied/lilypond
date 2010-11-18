%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.39"

\header {
  lsrtags = "editorial-annotations, text"

%% Translation of GIT committish: 5160eccb26cee0bfd802d844233e4a8d795a1e94
  texidoces = "
Se puede insertar códico PostScript directamente dentro de un
bloque @code{\\markup}.

"
  doctitlees = "Empotrar PostScript nativo dentro de un bloque \\markup"

  texidoc = "
PostScript code can be directly inserted inside a @code{\\markup}
block.

"
  doctitle = "Embedding native PostScript in a \\markup block"
} % begin verbatim

% PostScript is a registered trademark of Adobe Systems Inc.

\relative c'' {
  a4-\markup { \postscript #"3 4 moveto 5 3 rlineto stroke" }
  -\markup { \postscript #"[ 0 1 ] 0 setdash 3 5 moveto 5 -3 rlineto stroke " }

  b4-\markup { \postscript #"3 4 moveto 0 0 1 2 8 4 20 3.5 rcurveto stroke" }
  s2
  a'1
}

