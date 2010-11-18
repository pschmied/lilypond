%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.39"

\header {
  lsrtags = "chords"

%% Translation of GIT committish: 5160eccb26cee0bfd802d844233e4a8d795a1e94
  texidoces = "
La nomenclatura inglesa (predeterminada) para los acordes del cifrado
americano se puede cambiar por la alemana (@code{\\germanChords}
sustituye B y Bes por H y B) o por la semi-alemana
(@code{\\semiGermanChords} sustituye B y Bes por H y Bb).

"
  doctitlees = "Cambiar la nomenclatura de los acordes del cifrado americano por la notación alemana o semi-alemana"

  texidoc = "
The english naming of chords (default) can be changed to german
(@code{\\germanChords} replaces B and Bes with H and B) or semi-german
(@code{\\semiGermanChords} replaces B and Bes with H and Bb).




"
  doctitle = "Changing the chord names to German or semi-German notation"
} % begin verbatim

music = \chordmode {
  c1/c | cis/cis
  b1/b | bis/bis | bes/bes
}

%% The following is only here to print the names of the
%% chords styles; it can be removed if you do not need to
%% print them.

\layout {
  \context {
    \ChordNames
    \consists "Instrument_name_engraver"
  }
}

<<
  \new ChordNames {
    \set ChordNames.instrumentName = #"default"
    \music
  }
  \new ChordNames {
    \set ChordNames.instrumentName = #"german"
    \germanChords \music }
  \new ChordNames {
    \set ChordNames.instrumentName = #"semi-german"
    \semiGermanChords \music }
  \context Voice { \music }
>>

