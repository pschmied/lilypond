\version "2.6.0"
\header {
  texidoc =
  "
The piano brace should be shifted horizontally if it  is enclosed in a bracket.
"
}

\layout {raggedright = ##t}


{
  \context StaffGroup <<
    c4
    \context PianoStaff <<
      \new Staff d
      \new Staff e
    >>
  >>
}



