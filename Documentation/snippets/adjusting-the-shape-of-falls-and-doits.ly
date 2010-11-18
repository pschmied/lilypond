%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.39"

\header {
  lsrtags = "expressive-marks"

%% Translation of GIT committish: 5160eccb26cee0bfd802d844233e4a8d795a1e94
  texidoces = "
Puede ser necesario trucar la propiedad
@code{shortest-duration-space} para poder ajustar el tamaño de las
caídas y subidas de tono («falls» y «doits»).

"
  doctitlees = "Ajustar la forma de las subidas y caídas de tono"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
texidocde = "
Die @code{shortest-duration-space}-Eigenschaft kann verändert werden, um
das Aussehen von unbestimmten Glissandi anzupassen.

"
  doctitlede = "Das Aussehen von unbestimmten Glissandi anpassen"

%% Translation of GIT committish: 217cd2b9de6e783f2a5c8a42be9c70a82195ad20
  texidocfr = "
La propriété @code{shortest-duration-space} peut devoir être retouchée
pour ajuster l'apparence des chutes ou sauts.

"
  doctitlefr = "Ajustement du galbe des chutes ou sauts"


  texidoc = "
The @code{shortest-duration-space} property may have to be tweaked to
adjust the shape of falls and doits.

"
  doctitle = "Adjusting the shape of falls and doits"
} % begin verbatim

\relative c'' {
  \override Score.SpacingSpanner #'shortest-duration-space = #4.0
  c2-\bendAfter #5
  c2-\bendAfter #-4.75
  c2-\bendAfter #8.5
  c2-\bendAfter #-6
}

