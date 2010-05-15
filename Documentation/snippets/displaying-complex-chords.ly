% Do not edit this file; it is automatically
% generated from Documentation/snippets/new
% This file is in the public domain.
%% Note: this file works from version 2.13.1
\version "2.13.20"

\header {
%% Translation of GIT committish: d2119a9e5e951c6ae850322f41444ac98d1ed492

  texidoces = "
He aquí una forma de imprimir un acorde en el que suena la misma nota
dos veces con distintas alteraciones.

"
  doctitlees = "Impresión de acordes complejos"

  lsrtags = "simultaneous-notes, chords"
  texidoc = "
Here is a way to display a chord where the same note is played twice
with different accidentals.
"
  doctitle = "Displaying complex chords"
} % begin verbatim


fixA = {
  \once \override Stem #'length = #9
}
fixB = {
  \once \override NoteHead #'X-offset = #1.7
  \once \override Stem #'rotation = #'(45 0 0)
  \once \override Stem #'extra-offset = #'(-0.2 . -0.2)
  \once \override Stem #'flag-style = #'no-flag
  \once \override Accidental #'extra-offset = #'(4 . 0)
}

\relative c' {
  << { \fixA <b d!>8 } \\ { \voiceThree \fixB dis } >> s
}
