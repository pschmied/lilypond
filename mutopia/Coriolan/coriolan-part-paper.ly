\version "1.3.120"
\paper {
	%\paperSixteen

	% Fine for my a4 laserprinter:
	%textheight = 285.0\mm;
	%linewidth = 190.0\mm;

	% Mandatory Mutopia settings:
	textheight = 270.0\mm;
	linewidth = 180.0\mm;

	\translator {
		\ThreadContext
		\consists "Rest_engraver";
		
		% Set value for engraver at thread level,
		% to override the default that is set in ScoreContext
		% for added engraver at Voice level
		devNullThread = #'()
	}
	\translator {
		\VoiceContext
		\remove "Rest_engraver";

		% The staff combine (bassi part) needs a
		% thread_devnull_engraver here.
		% Instead of maintaining two separate hierarchies,
		% we switch add it, but switch it off immediately.
		% --> move to Score level to be able to override
		% The staff combine part switches it on.
		
		%% devNullThread = #'never
		\consists "Thread_devnull_engraver";

		%\remove "Dynamic_engraver";
		%\remove "Text_engraver";
	}
	% We need the HaraKiri staff for Staff Combining,
	% but we better remove the Instrument_name_engraver.
	\translator {
		\HaraKiriStaffContext
		
		%\consists "Dynamic_engraver";
		%\consists "Text_engraver";

		\consists "Mark_engraver";
		\remove "Instrument_name_engraver";
	}
	\translator  {
		\OrchestralScoreContext
		skipBars = ##t 

		soloText = #"I."
		soloIIText = #"II."
		% By default, turn off the Thread_devnull_engraver
		% at Voice level
		devNullThread = #'never
		
		TimeSignature \override #'style = #'C
		BarNumber \override #'padding = #3
		RestCollision \override #'maximum-rest-count = #1
	}
}
