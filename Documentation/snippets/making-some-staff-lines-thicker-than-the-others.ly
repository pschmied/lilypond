%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.4"

\header {
  lsrtags = "staff-notation, editorial-annotations"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Se puede engrosar una línea del pentagrama con fines pedagógicos
(p.ej. la tercera línea o la de la clave de Sol).  Esto se puede
conseguir añadiendo más líneas muy cerca de la línea que se quiere
destacar, utilizando la propiedad @code{line-positions} del objeto
@code{StaffSymbol}.

"
  doctitlees = "Hacer unas líneas del pentagrama más gruesas que las otras"


%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Für den pädagogischen Einsatz kann eine Linie des Notensystems dicker
gezeichnet werden (z. B. die Mittellinie, oder um den Schlüssel hervorzuheben).
Das ist möglich, indem man zusätzliche Linien sehr nahe an der Linie, die
dicker erscheinen soll, einfügt.  Dazu wird die @code{line-positions}-Eigenschaft
herangezogen.

"
  doctitlede = "Eine Linie des Notensystems dicker als die anderen machen"

  texidoc = "
For pedagogical purposes, a staff line can be thickened (e.g., the
middle line, or to emphasize the line of the G clef).  This can be
achieved by adding extra lines very close to the line that should be
emphasized, using the @code{line-positions} property of the
@code{StaffSymbol} object.

"
  doctitle = "Making some staff lines thicker than the others"
} % begin verbatim

{
  \override Staff.StaffSymbol #'line-positions = #'(-4 -2 -0.2 0 0.2 2 4)
  d'4 e' f' g'
}

