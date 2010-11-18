%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.39"

\header {
  lsrtags = "text, paper-and-layout, titles"

  texidoc = "
A demonstration of all headers.

"
  doctitle = "Demonstrating all headers"
} % begin verbatim

\header {
  copyright = "copyright"
  title = "title"
  subtitle = "subtitle"
  composer = "composer"
  arranger = "arranger"
  instrument = "instrument"
  metre = "metre"
  opus = "opus"
  piece = "piece"
  poet = "poet"
  texidoc = "All header fields with special meanings."
  copyright = "public domain"
  enteredby = "jcn"
  source = "urtext"
}

\layout {
  ragged-right = ##f
}

\score {
  \relative c'' { c1 | c | c | c }
}

\score {
   \relative c'' { c1 | c | c | c }
   \header {
     title = "localtitle"
     subtitle = "localsubtitle"
     composer = "localcomposer"
     arranger = "localarranger"
     instrument = "localinstrument"
     metre = "localmetre"
     opus = "localopus"
     piece = "localpiece"
     poet = "localpoet"
     copyright = "localcopyright"
   }
}

