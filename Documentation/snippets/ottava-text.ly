%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.1"

\header {
  lsrtags = "pitches, text"

%% Translation of GIT committish: 674a5f874c07063ae56d55be25c55fc3b4bdb7bf
  texidoces = "
Internamente, la función @code{set-octavation} establece las
propiedades @code{ottavation} (por ejemplo, a @code{\"8va\"} o a
@code{\"8vb\"}) y @code{middleCPosition}.  Para sobreescribir el texto
del corchete, ajuste @code{ottavation} despues de invocar a
@code{set-octavation}.
"
  doctitlees = "Texto de octava alta y baja"
%% Translation of GIT committish: e75f1604a1b866c853dee42dbffcb7800c706a5f
  
  
texidocde = "
Intern setzt die @code{set-octavation}-Funktion die Eigenschaften
@code{ottavation} (etwa auf den Wert @code{\"8va\"} oder @code{\"8vb\"})
und @code{middleCPosition}.  Um den Text der Oktavierungsklammer zu
ändern, kann @code{ottavation} manuell gesetzt werden, nachdem
@code{set-octavation} benützt wurde.

"

doctitlede = "Ottava-Text"

  texidoc = "
Internally, @code{\\ottava} sets the properties @code{ottavation} (for
example, to @code{\"8va\"} or @code{\"8vb\"}) and
@code{middleCPosition}.  To override the text of the bracket, set
@code{ottavation} after invoking @code{\\ottava}.

"
  doctitle = "Ottava text"
} % begin verbatim

{
  \ottava #1
  \set Staff.ottavation = #"8"
  c''1
  \ottava #0
  c'1
  \ottava #1
  \set Staff.ottavation = #"Text"
  c''1
}
