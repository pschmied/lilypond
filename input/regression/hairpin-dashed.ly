\version "2.17.6"

\header {
  texidoc ="Hairpin crescendi may be dashed. "

}


\relative c' {
  \override Hairpin.style = #'dashed-line
  f2\< g c1 d4\> b a gis\! }     

