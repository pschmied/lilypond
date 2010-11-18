% Do not edit this file; it is automatically
% generated from Documentation/snippets/new
% This file is in the public domain.
%% Note: this file works from version 2.13.36
\version "2.13.39"

\header {
%% Translation of GIT committish: 5160eccb26cee0bfd802d844233e4a8d795a1e94
  texidoces = "
Se pueden subdividir las barras automáticamente.  Estableciendo la
propiedad @code{subdivideBeams}, las barras se subdividen en
posiciones de pulso (tal y como se especifica en @code{beatLength}).

"
  doctitlees = "Subdivisiones de barra automáticas"

  lsrtags = "rhythms"

  texidoc = "
Beams can be subdivided automatically.  By setting the property
@code{subdivideBeams}, beams are subdivided at beat positions (as
specified in @code{baseMoment}).

"
  doctitle = "Automatic beam subdivisions"
} % begin verbatim


\new Staff {
  \relative c'' {
    <<
      {
        \voiceOne
        \set subdivideBeams = ##t
        b32[ a g f c' b a g
        b32^"subdivide beams" a g f c' b a g]
      }
      \new Voice {
        \voiceTwo
        b32_"default"[ a g f c' b a g
        b32 a g f c' b a g]
      }
    >>
    \oneVoice
    \set baseMoment = #(ly:make-moment 1 8)
    \set beatStructure = #'(2 2 2 2)
    b32^"baseMoment 1 8"[ a g f c' b a g]
    \set baseMoment = #(ly:make-moment 1 16)
    \set beatStructure = #'(4 4 4 4)
    b32^"baseMoment 1 16"[ a g f c' b a g]
  }
}

