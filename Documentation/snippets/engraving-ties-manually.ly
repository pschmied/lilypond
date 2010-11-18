%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.39"

\header {
  lsrtags = "rhythms"

%% Translation of GIT committish: 5160eccb26cee0bfd802d844233e4a8d795a1e94
 doctitlees = "Grabado manual de las ligaduras"
 texidoces = "
Se pueden grabar a mano las ligaduras modificando la propiedad
@code{tie-configuration} del objeto @code{TieColumn}. El primer número
indica la distancia a partir de la tercera línea del pentagrama en
espacios de pentagrama, y el segundo número indica la dirección (1 =
hacia arriba, -1 = hacia abajo).

"


%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
texidocde = "
Überbindungen können manuell gesetzt werden, indem man die
@code{tie-configuration}-Eigenschaft des @code{TieColumn}-Objekts
beeinflusst.  Die erste Zahl zeigt den Abstand von der Mitte in
Notensystemabständen an, die zweite Zahl zeigt die Richtung an (1 = nach oben,
-1 = nach unten).

"
  doctitlede = "Bindebögen manuell setzen"



%% Translation of GIT committish: 4da4307e396243a5a3bc33a0c2753acac92cb685
  texidocfr = "
Il est possible de graver manuellement les liaisons de tenue, en
modifiant la propriété @code{tie-configuration}.  Pour chaque paire, le
premier nombre indique la distance à la portée, en espaces de portée, et
le second la direction (1 pour haut, @minus{}1 pour bas).

"
  doctitlefr = "Dessin à main levée de liaisons de tenue"

  texidoc = "
Ties may be engraved manually by changing the @code{tie-configuration}
property of the @code{TieColumn} object. The first number indicates the
distance from the center of the staff in staff-spaces, and the second
number indicates the direction (1 = up, -1 = down).

"
  doctitle = "Engraving ties manually"
} % begin verbatim

\relative c' {
  <c e g>2 ~ <c e g>
  \override TieColumn #'tie-configuration =
    #'((0.0 . 1) (-2.0 . 1) (-4.0 . 1))
  <c e g>2 ~ <c e g>
}

