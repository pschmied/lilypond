/*
  This file is part of LilyPond, the GNU music typesetter.

  Copyright (C) 2010--2015 Neil Puttock <n.puttock@gmail.com>

  LilyPond is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  LilyPond is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with LilyPond.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "context.hh"
#include "global-context.hh"
#include "input.hh"
#include "international.hh"
#include "moment.hh"
#include "music.hh"
#include "simple-music-iterator.hh"

class Partial_iterator : public Simple_music_iterator
{
public:
  DECLARE_SCHEME_CALLBACK (constructor, ());
  DECLARE_SCHEME_CALLBACK (finalization, (SCM, SCM));
protected:
  virtual void process (Moment);
};

void
Partial_iterator::process (Moment m)
{
  if (Duration * dur
      = Duration::unsmob (get_music ()->get_property ("duration")))
    {
      Moment length = Moment (dur->get_length ());

      // Partial_iterator is an iterator rather than an engraver,
      // so the active context it is getting called in does not
      // depend on which context definition the engraver might be
      // defined.
      //
      // Using where_defined to find the context where
      // measurePosition should be overwritten does not actually
      // work since the Timing_translator does not set
      // measurePosition when initializing.

      Context *timing = Context::unsmob
                        (scm_call_2 (ly_lily_module_constant ("ly:context-find"),
                                     get_outlet ()->self_scm (),
                                     ly_symbol2scm ("Timing")));

      if (!timing)
        programming_error ("missing Timing in \\partial");
      else if (get_outlet ()->now_mom () > 0)
        {
          timing->set_property ("partialBusy", ly_bool2scm (true));
          Global_context *tg = get_outlet ()->get_global_context ();
          tg->add_finalization (scm_list_3 (finalization_proc,
                                            get_outlet ()->self_scm (),
                                            length.smobbed_copy ()));
        }
      else
        {
          Moment mp = robust_scm2moment
                      (timing->get_property ("measurePosition"),
                       Rational (0));
          mp.main_part_ = 0;
          timing->set_property
          ("measurePosition", (mp - length).smobbed_copy ());
        }
    }
  else
    programming_error ("invalid duration in \\partial");

  Simple_music_iterator::process (m);
}

IMPLEMENT_CTOR_CALLBACK (Partial_iterator);

MAKE_SCHEME_CALLBACK (Partial_iterator, finalization, 2);
SCM
Partial_iterator::finalization (SCM ctx, SCM length)
{
  LY_ASSERT_SMOB (Context, ctx, 1);
  LY_ASSERT_SMOB (Moment, length, 2);
  Context *timing = Context::unsmob
    (scm_call_2 (ly_lily_module_constant ("ly:context-find"),
                 ctx,
                 ly_symbol2scm ("Timing")));
  if (!timing) {
    programming_error ("missing Timing in \\partial");
    return SCM_UNSPECIFIED;
  }
  Moment mp = robust_scm2moment (timing->get_property ("measurePosition"),
                                 Rational (0));
  mp.main_part_ = measure_length (timing);
  timing->set_property ("measurePosition",
                        (mp - *Moment::unsmob (length)).smobbed_copy ());
  timing->unset_property (ly_symbol2scm ("partialBusy"));

  return SCM_UNSPECIFIED;
}
