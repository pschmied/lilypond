%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.39"

\header {
  lsrtags = "simultaneous-notes"

%% Translation of GIT committish: 5160eccb26cee0bfd802d844233e4a8d795a1e94
 doctitlees = "Voces adicionales para evitar colisiones"
 texidoces = "
En ciertos casos de polifonía compleja, se necesitan voces adicionales
para evitar colisiones entre las notas.  Si se necesitan más de cuatro
voces paralelas, las voces adicionales se añaden definiendo una
variable que utiliza la función de Scheme @code{context-spec-music}.

"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Ein einigen Fällen von sehr komplexer polyphoner Musik sind zusätzliche
Stimmen notwendig, um Zusammenstöße zwischen den Noten zu vermeiden.
Wenn mehr als vier parallele Stimmen benötigt werden, können zusätzliche
Stimmen definiert werden, indem eine Variable mit der Funktion
@code{context-spec-music} definiert wird.

"
  doctitlede = "Zusätzliche Stimmen um Zusammenstöße zu vermeiden"

%% Translation of GIT committish: 1baa2adf57c84e8d50e6907416eadb93e2e2eb5c
  texidocfr = "
Dans certains cas de musique polyphonie complexe, une voix
supplémentaire peut permettre d'éviter les risques de collision.
Lorsque quatre voix parallèles ne suffisent pas, la fonction Scheme
@code{context-spec-music} permet d'ajouter des d'autres voix.

"
  doctitlefr = "Ajout de voix pour éviter les collisions"


  texidoc = "
In some instances of complex polyphonic music, additional voices are
necessary to prevent collisions between notes.  If more than four
parallel voices are needed, additional voices can be added by defining
a variable using the Scheme function @code{context-spec-music}.

"
  doctitle = "Additional voices to avoid collisions"
} % begin verbatim

voiceFive = #(context-spec-music (make-voice-props-set 4) 'Voice)

\relative c'' {
  \time 3/4
  \key d \minor
  \partial 2
  <<
    {
      \voiceOne
      a4. a8
      e'4 e4. e8
      f4 d4. c8
    }
    \\
    {
      \voiceThree
      f,2
      bes4 a2
      a4 s2
    }
    \\
    {
      \voiceFive
      s2
      g4 g2
      f4 f2
    }
    \\
    \bar "||"{
      \voiceTwo
      d2
      d4 cis2
      d4 bes2
    }
  >>
}

