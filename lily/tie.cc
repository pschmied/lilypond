/*
  This file is part of LilyPond, the GNU music typesetter.

  Copyright (C) 1997--2015 Han-Wen Nienhuys <hanwen@xs4all.nl>

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

#include "tie.hh"

#include "main.hh"
#include "bezier.hh"
#include "directional-element-interface.hh"
#include "font-interface.hh"
#include "grob-array.hh"
#include "lookup.hh"
#include "note-head.hh"
#include "output-def.hh"
#include "paper-column.hh"
#include "pointer-group-interface.hh"
#include "rhythmic-head.hh"
#include "spanner.hh"
#include "staff-symbol-referencer.hh"
#include "stem.hh"
#include "text-interface.hh"
#include "tie-column.hh"
#include "tie-configuration.hh"
#include "tie-formatting-problem.hh"
#include "warn.hh"
#include "semi-tie-column.hh"

bool
Tie::less (Grob *const &s1, Grob *const &s2)
{
  return Tie::get_position (s1) < Tie::get_position (s2);
}

void
Tie::set_head (Grob *me, Direction d, Grob *h)
{
  dynamic_cast<Spanner *> (me)->set_bound (d, h);
}

Grob *
Tie::head (Grob *me, Direction d)
{
  if (is_direction (me->get_property ("head-direction")))
    {
      Direction hd = to_dir (me->get_property ("head-direction"));

      return (hd == d)
             ? Grob::unsmob (me->get_object ("note-head"))
             : 0;
    }

  Item *it = dynamic_cast<Spanner *> (me)->get_bound (d);
  if (Note_head::has_interface (it))
    return it;
  else
    return 0;
}

int
Tie::get_column_rank (Grob *me, Direction d)
{
  Grob *col = 0;
  Spanner *span = dynamic_cast<Spanner *> (me);
  if (!span)
    col = dynamic_cast<Item *> (me)->get_column ();
  else
    {
      Grob *h = head (me, d);
      if (!h)
        h = span->get_bound (d);

      col = dynamic_cast<Item *> (h)->get_column ();
    }
  return Paper_column::get_rank (col);
}

int
Tie::get_position (Grob *me)
{
  for (LEFT_and_RIGHT (d))
    {
      Grob *h = head (me, d);
      if (h)
        return (int) rint (Staff_symbol_referencer::get_position (h));
    }

  /*
    TODO: this is theoretically possible for ties across more than 2
    systems.. We should look at the first broken copy.

  */
  programming_error ("Tie without heads.  Suicide");
  me->suicide ();
  return 0;
}

/*
  Default:  Put the tie oppositie of the stem [Wanske p231]

  In case of chords: Tie_column takes over

  The direction of the Tie is more complicated (See [Ross] p136 and
  further).

  (what about linebreaks? )
*/
Direction
Tie::get_default_dir (Grob *me)
{
  Drul_array<Grob *> stems;
  for (LEFT_and_RIGHT (d))
    {
      Grob *one_head = head (me, d);
      if (!one_head && dynamic_cast<Spanner *> (me))
        one_head = Tie::head (dynamic_cast<Spanner *> (me)->broken_neighbor (d), d);

      Grob *stem = one_head ? Rhythmic_head::get_stem (one_head) : 0;
      if (stem)
        stem = Stem::is_invisible (stem) ? 0 : stem;

      stems[d] = stem;
    }

  if (stems[LEFT] && stems[RIGHT])
    {
      if (get_grob_direction (stems[LEFT]) == UP
          && get_grob_direction (stems[RIGHT]) == UP)
        return DOWN;
    }
  else if (stems[LEFT] || stems[RIGHT])
    {
      Grob *s = stems[LEFT] ? stems[LEFT] : stems[RIGHT];
      return -get_grob_direction (s);
    }
  else if (int p = get_position (me))
    return Direction (sign (p));

  return to_dir (me->get_property ("neutral-direction"));
}

MAKE_SCHEME_CALLBACK (Tie, calc_direction, 1);
SCM
Tie::calc_direction (SCM smob)
{
  Grob *me = Grob::unsmob (smob);
  Grob *yparent = me->get_parent (Y_AXIS);
  if ((Tie_column::has_interface (yparent)
       || Semi_tie_column::has_interface (yparent))
      && Grob_array::is_smob (yparent->get_object ("ties"))
      //      && Grob_array::unsmob (yparent->get_object ("ties"))->size () > 1
     )
    {
      /* trigger positioning. */
      (void) yparent->get_property ("positioning-done");

      return me->get_property_data ("direction");
    }
  else
    return scm_from_int (Tie::get_default_dir (me));
}

SCM
Tie::get_default_control_points (Grob *me_grob)
{
  Spanner *me = dynamic_cast<Spanner *> (me_grob);
  Grob *common = me;
  common = me->get_bound (LEFT)->common_refpoint (common, X_AXIS);
  common = me->get_bound (RIGHT)->common_refpoint (common, X_AXIS);

  Tie_formatting_problem problem;
  problem.from_tie (me);

  if (!me->is_live ())
    return SCM_EOL;

  Ties_configuration conf
    = problem.generate_optimal_configuration ();

  return get_control_points (me, problem.common_x_refpoint (),
                             conf[0], problem.details_);
}

SCM
Tie::get_control_points (Grob *me,
                         Grob *common,
                         Tie_configuration const &conf,
                         Tie_details const &details)
{
  Bezier b = conf.get_transformed_bezier (details);
  b.translate (Offset (- me->relative_coordinate (common, X_AXIS), 0));

  SCM controls = SCM_EOL;
  for (int i = 4; i--;)
    {
      if (!b.control_[i].is_sane ())
        programming_error ("Insane offset");
      controls = scm_cons (ly_offset2scm (b.control_[i]), controls);
    }
  return controls;
}

MAKE_SCHEME_CALLBACK (Tie, calc_control_points, 1);
SCM
Tie::calc_control_points (SCM smob)
{
  Grob *me = Grob::unsmob (smob);

  Grob *yparent = me->get_parent (Y_AXIS);
  if ((Tie_column::has_interface (yparent)
       || Semi_tie_column::has_interface (yparent))
      && Grob_array::is_smob (yparent->get_object ("ties")))
    {
      extract_grob_set (yparent, "ties", ties);
      if (me->original () && ties.size () == 1
          && !to_dir (me->get_property_data ("direction")))
        {
          assert (ties[0] == me);
          set_grob_direction (me, Tie::get_default_dir (me));
        }
      /* trigger positioning. */
      (void) yparent->get_property ("positioning-done");
    }

  SCM cp = me->get_property_data ("control-points");
  if (!scm_is_pair (cp))
    cp = get_default_control_points (me);

  return cp;
}

/*
  TODO: merge with Slur::print.
*/
MAKE_SCHEME_CALLBACK (Tie, print, 1);
SCM
Tie::print (SCM smob)
{
  Grob *me = Grob::unsmob (smob);

  SCM cp = me->get_property ("control-points");

  Real staff_thick = Staff_symbol_referencer::line_thickness (me);
  Real base_thick = staff_thick * robust_scm2double (me->get_property ("thickness"), 1);
  Real line_thick = staff_thick * robust_scm2double (me->get_property ("line-thickness"), 1);

  Bezier b;
  int i = 0;
  for (SCM s = cp; scm_is_pair (s); s = scm_cdr (s))
    {
      b.control_[i] = ly_scm2offset (scm_car (s));
      i++;
    }

  Stencil a;

  SCM dash_definition = me->get_property ("dash-definition");
  a = Lookup::slur (b,
                    get_grob_direction (me) * base_thick,
                    line_thick,
                    dash_definition);

#if DEBUG_TIE_SCORING
  SCM annotation = me->get_property ("annotation");
  if (scm_is_string (annotation))
    {
      string str;
      SCM properties = Font_interface::text_font_alist_chain (me);

      Stencil tm = *Stencil::unsmob (Text_interface::interpret_markup
                                    (me->layout ()->self_scm (), properties,
                                     annotation));
      tm.translate (Offset (b.control_[3][X_AXIS] + 0.5,
                            b.control_[0][Y_AXIS] * 2));
      tm = tm.in_color (1, 0, 0);

      /*
        It would be nice if we could put this in a different layer,
        but alas, this must be done with a Tie override.
      */
      a.add_stencil (tm);
    }
#endif

  return a.smobbed_copy ();
}

ADD_INTERFACE (Tie,
               "A tie - a horizontal curve connecting two noteheads.\n"
               "\n"
               "The following properties may be set in the @code{details}"
               " list.\n"
               "\n"
               "@table @code\n"
               "@item height-limit\n"
               "The maximum height allowed for this tie.\n"
               "@item ratio\n"
               "Parameter for tie shape. The higher this number, the"
               " quicker the slur attains its height-limit.\n"
               "@item between-length-limit\n"
               "This detail is currently unused.\n"
               "@item wrong-direction-offset-penalty\n"
               "Demerit for ties that are offset in the wrong"
               " direction.\n"
               "@item min-length\n"
               "If the tie is shorter than this amount (in"
               " staff-spaces) an increasingly large length penalty is"
               " incurred.\n"
               "@item min-length-penalty-factor\n"
               "Demerit factor for tie lengths shorter than"
               " @code{min-length}.\n"
               "@item center-staff-line-clearance\n"
               "If the center of the tie is closer to a staff line"
               " than this amount, an increasingly large staff line"
               " collision penalty is incurred.\n"
               "@item tip-staff-line-clearance\n"
               "If the tips of the tie are closer to a staff line"
               " than this amount, an increasingly large staff line"
               " collision penalty is incurred.\n"
               "@item staff-line-collision-penalty\n"
               "Demerit factor for ties whose tips or center come"
               " close to staff lines.\n"
               "@item dot-collision-clearance\n"
               "If the tie comes closer to a dot than this amount, an"
               " increasingly large dot collision penalty is incurred.\n"
               "@item dot-collision-penalty\n"
               "Demerit factor for ties which come close to dots.\n"
               "@item note-head-gap\n"
               "The distance (in staff-spaces) by which the ends of"
               " the tie are offset horizontally from the center"
               " line through the note head.\n"
               "@item stem-gap\n"
               "The distance (in staff-spaces) by which the ends of"
               " the tie are offset horizontally from a stem which"
               " is on the same side of the note head as the tie.\n"
               "@item tie-column-monotonicity-penalty\n"
               "Demerit if the y-position of this tie in the set of"
               " ties being considered is less than the y-position"
               " of the previous tie.\n"
               "@item tie-tie-collision-distance\n"
               "If this tie is closer than this amount to the previous"
               " tie in the set being considered, an increasingly"
               " large tie-tie collision penalty is incurred.\n"
               "@item tie-tie-collision-penalty\n"
               "Demerit factor for a tie in the set being considered"
               " which is close to the previous one.\n"
               "@item horizontal-distance-penalty-factor\n"
               "Demerit factor for ties in the set being considered"
               " which are horizontally distant from the note heads.\n"
               "@item vertical-distance-penalty-factor\n"
               "Demerit factor for ties in the set being considered"
               " which are vertically distant from the note heads.\n"
               "@item same-dir-as-stem-penalty\n"
               "Demerit if tie is on the same side as a stem or on the"
               " opposite side to the one specified.\n"
               "@item intra-space-threshold\n"
               "If the tie's height (in half staff-spaces) is less than"
               " this it is positioned between two adjacent staff"
               " lines; otherwise it is positioned to straddle a staff"
               " line further from the note heads.\n"
               "@item outer-tie-length-symmetry-penalty-factor\n"
               "Demerit factor for ties horizontally positioned"
               " unsymmetrically with respect to the two note heads.\n"
               "@item outer-tie-vertical-distance-symmetry-penalty-factor\n"
               "Demerit factor for ties vertically positioned"
               " unsymmetrically with respect to the two note heads.\n"
               "@item outer-tie-vertical-gap\n"
               "Amount (in half staff-spaces) by which a tie is moved"
               " away from the note heads if it is closer to either"
               " of them than 0.25 half staff-spaces.\n"
               "@item skyline-padding\n"
               "Padding of the skylines around note heads in chords.\n"
               "@item single-tie-region-size\n"
               "The number of candidate ties to generate when only a"
               " single tie is required.  Successive candidates differ"
               " in their initial vertical position by half a"
               " staff-space.\n"
               "@item multi-tie-region-size\n"
               "The number of variations that are tried for the"
               " extremal ties in a chord.  Variations differ in their"
               " initial vertical position by half a staff-space.\n"

               "@end table\n",

               /* properties */
               "annotation "
               "avoid-slur "    //  UGH.
               "control-points "
               "dash-definition "
               "details "
               "direction "
               "head-direction "
               "line-thickness "
               "neutral-direction "
               "staff-position "
               "thickness "
              );
