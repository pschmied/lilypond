%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.39"

\header {
  lsrtags = "expressive-marks, text, tweaks-and-overrides"

%% Translation of GIT committish: 5160eccb26cee0bfd802d844233e4a8d795a1e94
  texidoces = "
Las instrucciones @code{\\startTextSpan} y @code{\\stopTextSpan}
permiten la creación de elementos de extensión textuales tan
fácilmente como indicaciones de pedal u
octavaciones. Sobreescribimos ciertas propiedades del objeto
@code{TextSpanner} para modificar su salida.

"
  doctitlees = "Crear elementos de extensión textuales"

  texidoc = "
The @code{\\startTextSpan} and @code{\\stopTextSpan} commands allow the
creation of text spanners as easily as pedal indications or
octavations. Override some properties of the @code{TextSpanner} object
to modify its output.

"
  doctitle = "Creating text spanners"
} % begin verbatim

\paper { ragged-right = ##f }

\relative c'' {
  \override TextSpanner #'(bound-details left text) = #"bla"
  \override TextSpanner #'(bound-details right text) = #"blu"
  a4 \startTextSpan
  b4 c
  a4 \stopTextSpan

  \override TextSpanner #'style = #'line
  \once \override TextSpanner
    #'(bound-details left stencil-align-dir-y) = #CENTER
  a4 \startTextSpan
  b4 c
  a4 \stopTextSpan

  \override TextSpanner #'style = #'dashed-line
  \override TextSpanner #'(bound-details left text) =
    \markup { \draw-line #'(0 . 1) }
  \override TextSpanner #'(bound-details right text) =
    \markup { \draw-line #'(0 . -2) }
  \once \override TextSpanner #'(bound-details right padding) = #-2

  a4 \startTextSpan
  b4 c
  a4 \stopTextSpan

  \set Staff.middleCPosition = #-13
  \override TextSpanner #'dash-period = #10
  \override TextSpanner #'dash-fraction = #0.5
  \override TextSpanner #'thickness = #10
  a4 \startTextSpan
  b4 c
  a4 \stopTextSpan
}

