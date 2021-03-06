%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.18.0"

\header {
  lsrtags = "contemporary-notation, contexts-and-engravers, rhythms, workaround"

  texidoc = "
The @code{measureLength} property, together with
@code{measurePosition}, determines when a bar line is needed.  However,
when using @code{\\scaleDurations}, the scaling of durations makes it
difficult to change time signatures.  In this case,
@code{measureLength} should be set manually, using the
@code{ly:make-moment} callback.  The second argument must be the same
as the second argument of @code{\\scaleDurations}.

"
  doctitle = "Changing time signatures inside a polymetric section using \\scaleDurations"
} % begin verbatim

\layout {
  \context {
    \Score
    \remove "Timing_translator"
    \remove "Default_bar_line_engraver"
  }
  \context {
    \Staff
    \consists "Timing_translator"
    \consists "Default_bar_line_engraver"
  }
}

<<
  \new Staff {
    \scaleDurations 8/5 {
      \time 6/8
      \set Timing.measureLength = #(ly:make-moment 6/5)
      b8 b b b b b
      \time 2/4
      \set Timing.measureLength = #(ly:make-moment 4/5)
      b4 b
    }
  }
  \new Staff {
    \clef bass
    \time 2/4
    c2 d e f
  }
>>
