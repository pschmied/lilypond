% Do not edit this file; it is automatically
% generated from Documentation/snippets/new
% This file is in the public domain.
%% Note: this file works from version 2.13.36
\version "2.13.39"

\header {
%% Translation of GIT committish: 5160eccb26cee0bfd802d844233e4a8d795a1e94

  texidoces = "
Los objetos de extensión \cresc, \dim y \decresc ahora se pueden
redefinir como operadores postfijos y producir un solo objeto de
extensión de texto.  La definición de extensores personalizados
también es fácil.  Se pueden mezclar con facilidad los crescendi
textuales y en forma de reguladores. \< y \> producen reguladores
gráficos de forma predeterminada, \cresc etc. producen elementos
extensores de texto de forma predeterminada.

"

  doctitlees = "Objetos extensores de texto postfijos para dinámica"

%%   Translation of GIT committish: ab9e3136d78bfaf15cc6d77ed1975d252c3fe506


  texidocde = "Die \cresc, \dim und \decresc Strecker können umdefiniert werden,
um nachgestellt zu funktionieren und einen Textstrecker zu produzieren.  Eigene
Strecker können auch einfach definiert werden.  Klammer- und Textcrescendi können
einfach vermischt werden.  \< und \> erstellen normalerweise Klammern, \cresc
usw. dagegen normalerweise Textspanner.

"
  doctitlede = "Dynamiktextstrecker nachgestellt"



%% Translation of GIT committish: a06cb0b0d9593ba110e001f2b0f44b8bef084693

  texidocfr = "
Les lignes d'extension des commandes \cresc, \dim et \decresc peuvent
désormais être personnalisées facilement sous forme d'opérateurs
postfix.  Soufflets et (de)crescendos peuvent cohabiter.  \< et \>
produiront par défaut des soufflets, alors que \cresc etc. produiront
une indication textuelle avec extension.

"

  doctitlefr = "Extensions de nuance postfix"


  lsrtags = "expressive-marks, tweaks-and-overrides"
  texidoc = "The \cresc, \dim and \decresc spanners can now be redefined as
postfix operators and produce one text spanner.  Defining custom spanners is
also easy.  Hairpin and text crescendi can be easily mixed. \< and \> produce
hairpins by default, \cresc etc. produce text spanners by default.
"
  doctitle = "Dynamics text spanner postfix"
} % begin verbatim


% Some sample text dynamic spanners, to be used as postfix operators
crpoco =
#(make-music 'CrescendoEvent
             'span-direction START
             'span-type 'text
             'span-text "cresc. poco a poco")
% Redefine the existing \cresc, \dim and \decresc commands to use postfix syntax
cresc =
#(make-music 'CrescendoEvent
             'span-direction START
             'span-type 'text
             'span-text "cresc.")
dim =
#(make-music 'DecrescendoEvent
             'span-direction START
             'span-type 'text
             'span-text "dim.")
decresc =
#(make-music 'DecrescendoEvent
             'span-direction START
             'span-type 'text
             'span-text "decresc.")

\relative c' {
  c4\cresc d4 e4 f4 |
  g4 a4\! b4\crpoco c4 |
  c4 d4 e4 f4 |
  g4 a4\! b4\< c4 |
  g4\dim a4 b4\decresc c4\!
}

