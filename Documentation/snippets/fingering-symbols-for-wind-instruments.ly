%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.39"

\header {
  lsrtags = "winds"

%% Translation of GIT committish: 298a2c322d7e4f437f3dd1a24db2839e3f35acce
  texidoces = "
Se pueden conseguir símbolos especiales combinando glifos existentes,
lo que es de utilidad para la notación de instrumentos de viento.

"
  doctitlees = "Símbolos de digitación para instrumentos de viento"

%% Translation of GIT committish: 496c48f1f2e4d345ae3637b2c38ec748a55cda1d
  texidocfr = "
Des sumboles spécifiques peuvent être obtenus en combinant les glyphes
disponibles, ce qui est tout à fait indiqué en matière d'instrument à vent.

"
  doctitlefr = "Symboles de doigtés pour instruments à vent"


  texidoc = "
Special symbols can be achieved by combining existing glyphs, which is
useful for wind instruments.

"
  doctitle = "Fingering symbols for wind instruments"
} % begin verbatim

centermarkup = {
  \once \override TextScript #'self-alignment-X = #CENTER
  \once \override TextScript #'X-offset =#(ly:make-simple-closure
    `(,+
      ,(ly:make-simple-closure (list
        ly:self-alignment-interface::centered-on-x-parent))
      ,(ly:make-simple-closure (list
        ly:self-alignment-interface::x-aligned-on-self))))
}
\score
{\relative c'
  {
    g\open
    \once \override TextScript #'staff-padding = #-1.0 \centermarkup
    g^\markup{\combine \musicglyph #"scripts.open" \musicglyph
    #"scripts.tenuto"}
    \centermarkup g^\markup{\combine \musicglyph #"scripts.open"
    \musicglyph #"scripts.stopped"}
    g\stopped
  }
}

