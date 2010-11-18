%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.39"

\header {
  lsrtags = "expressive-marks, tweaks-and-overrides"

%% Translation of GIT committish: 5160eccb26cee0bfd802d844233e4a8d795a1e94
  texidoces = "
Los reguladores pueden imprimirse en uno cualquiera de los estilos de
@code{line-interface}: discontinuo, punteado, línea, trino o zig-zag.

"
  doctitlees = "Reguladores con distintos estilos de línea"



  texidoc = "
Hairpins can take any style from @code{line-interface} - dashed-line,
dotted-line, line, trill or zigzag.

"
  doctitle = "Hairpins with different line styles"
} % begin verbatim

\relative c' {
  c2\< c\!
  \override Hairpin #'style = #'dashed-line
  c2\< c\!
  \override Hairpin #'style = #'dotted-line
  c2\< c\!
  \override Hairpin #'style = #'line
  c2\< c\!
  \override Hairpin #'style = #'trill
  c2\< c\!
  \override Hairpin #'style = #'zigzag
  c2\< c\!
  \revert Hairpin #'style
  c2\< c\!
}

