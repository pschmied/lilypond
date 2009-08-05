%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.4"

\header {
  lsrtags = "text"

%% Translation of GIT committish: b2d4318d6c53df8469dfa4da09b27c15a374d0ca
  texidoces = "
Los textos independientes se pueden disponer en varias columnas
utilizando instrucciones @code{\\markup}:

"
  doctitlees = "Elemento de marcado de texto independiente en dos columnas"


%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
  texidocde = "
Isolierter Text kann in mehreren Spalten mit @code{\\markup}-Befehlen
angeordnet werden:

"
  doctitlede = "Isolierter Text in zwei Spalten"

  texidoc = "
Stand-alone text may be arranged in several columns using
@code{\\markup} commands:

"
  doctitle = "Stand-alone two-column markup"
} % begin verbatim

\markup {
  \fill-line {
    \hspace #1
    \column {
      \line { O sacrum convivium }
      \line { in quo Christus sumitur, }
      \line { recolitur memoria passionis ejus, }
      \line { mens impletur gratia, }
      \line { futurae gloriae nobis pignus datur. }
      \line { Amen. }
    }
    \hspace #2
    \column {
      \line { \italic { O sacred feast } }
      \line { \italic { in which Christ is received, } }
      \line { \italic { the memory of His Passion is renewed, } }
      \line { \italic { the mind is filled with grace, } }
      \line { \italic { and a pledge of future glory is given to us. } }
      \line { \italic { Amen. } }
    }
    \hspace #1
  }
}
