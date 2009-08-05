% Do not edit this file; it is automatically
% generated from Documentation/snippets/new
% This file is in the public domain.
%% Note: this file works from version 2.13.0
\version "2.13.4"

\header {
%% Translation of GIT committish: da7ce7d651c3a0d1bfed695f6e952975937a1c79
  texidoces = "
Se puede hacer que los diagramas de posiciones se muestren sólo
cuando el acorde cambia o al comienzo de una nueva línea.

"

  doctitlees = "Cambios de acorde de posiciones de trastes"


%% Translation of GIT committish: d96023d8792c8af202c7cb8508010c0d3648899d
texidocde = "
Bunddiagramme können definiert werden, sodass sie nur angezeigt werden,
wenn der Akkord sich ändert oder eine neue Zeile anfängt.

"

  doctitlede = "Akkordänderungen für Bunddiagramme"

  lsrtags = "fretted-strings"
  texidoc = "FretBoards can be set to display only when the chord changes
or at the beginning of a new line."
  doctitle = "chordChanges for FretBoards"
} % begin verbatim


\include "predefined-guitar-fretboards.ly"

myChords = \chordmode {
  c1 c1 \break
  \set chordChanges = ##t
  c1 c1 \break
  c1 c1 \break
}

<<
  \new ChordNames { \myChords }
  \new FretBoards { \myChords }
  \new Staff { \myChords }
>>
